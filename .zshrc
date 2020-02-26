# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# import shared bash scripts
source ~/.aliases
source ~/.exports
source ~/.secrets
source ~/.functions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# https://github.com/romkatv/powerlevel10k#zinit
zinit ice depth=1 lucid
zinit light romkatv/powerlevel10k

# ZSH options
setopt no_beep                # don't beep on error
setopt interactive_comments   # Allow comments even in interactive shells (especially for Muness)

setopt auto_cd                # type foo, and its not a command, but a directory in cdpath, go there
setopt cdablevarS             # cd $param becomes current directory when value is a valid directory
setopt pushd_ignore_dups      # don't push multiple copies of the same dir onto the stack

setopt extended_glob          # treat #, ~, and ^ as part of patterns for filename generation

setopt append_history         # Allow multiple terminal sessions to append to one zsh history
setopt extended_history       # save timestamp of command and duration
setopt inc_append_history     # Add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups       # Do not write events to history that are duplicates of prior events
setopt hist_ignore_space      # remove command line from history when first character is a space
setopt hist_find_no_dups      # When searching history don't redisplay results cycled through twice
setopt hist_reduce_blanks     # Remove extra blanks from each command line being added to history
setopt hist_verify            # don't execute, just expand history
setopt share_history          # imports new commands and appends typed commands to history

setopt always_to_end          # When completing from the middle of a word, move the cursor to end
setopt auto_menu              # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs         # any parameter set to the absolute path immediately becomes a name for that directory
setopt complete_in_word       # Allow completion from within a word/phrase

unsetopt menu_complete        # do not autoselect the first completion entry

unsetopt correct_all          # spelling correction for arguments
setopt correct                # spelling correction for commands

setopt prompt_subst           # Enable param + arithmetic expansion, command substitution in prompt
# setopt transient_rprompt    # only show the rprompt on the current prompt

setopt longlistjobs           # display PID when suspending processes as well
setopt multios                # perform implicit tees or cats with multiple redirections

###############################################################################
## COMPLETIONS ONLY
###############################################################################

# homebrew installs completions in /usr/local/share/zsh/site-functions
# _aws _brew _brew_cask _fd _gh _git _helm _lpass _rg _tmuxinator aws_zsh_completer.sh git-completion.bash
# zinit installs completions in $ZINIT[COMPLETIONS_DIR] (typically $HOME/.zinit/completions)

# some tools provide completions via a CLI invocation (that will best match tool)
# OMZ::plugins/kubectl/kubectl.plugin.zsh adds unnecessary aliases and writes to wrong location
zinit ice as"completion" wait"2" lucid atclone'kubectl completion zsh >! _kubectl; \
    rustup completions zsh cargo >! _cargo; \
    rustup completions zsh >! _rustup; \
    minikube completion zsh >! _minikube' \
     atpull'%atclone' multisrc"_kubectl _cargo _rustup _minikube" run-atpull
zinit light zdharma/null

# NOTE: rspec doesn't appear to be working properly?
# _gem is more robust than OMZ variant
# rust at https://github.com/sainnhe/rust-zsh-completions looks thorough, but already have cargo / rustup
zinit as"completion" wait"2" lucid light-mode for \
  https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker \
  https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose \
  https://github.com/nono/dotfiles/blob/master/zsh/Completion/_gem \
  https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh \
  https://github.com/zsh-users/zsh-completions/blob/master/src/_glances \
  OMZ::plugins/httpie/_httpie \
  https://github.com/zsh-users/zsh-completions/blob/master/src/_openssl \
  https://github.com/zsh-users/zsh-completions/blob/master/src/_rspec \
  OMZ::plugins/rust/_rust \
  https://github.com/zsh-users/zsh-completions/blob/master/src/_subl
  # OMZ::plugins/terraform/_terraform
  # OMZ::plugins/vagrant/_vagrant

###############################################################################
## PLUGINS with COMPLETIONS
###############################################################################

# bundler - add additional gems with BUNDLED_COMMANDS=()
# extract - adds a function for extracting files
# golang - go completions, some aliases
# osx - adds commands tab, split_tab, vsplit_tab, ofd, pfd, pfs, cdf, pushdf, quick-look, man-preview, showfiles, hidefiles, itunes, music, spotify, rmdsstore
# per-directory-history - stores per directory history, Ctrl-G to toggle
zinit wait"1" svn lucid light-mode for \
  OMZ::plugins/bundler \
  OMZ::plugins/extract \
  OMZ::plugins/golang \
  OMZ::plugins/osx
# OMZ::plugins/per-directory-history

###############################################################################
## PLUGINS
###############################################################################

# hightly customized LS_COLORS support with https://github.com/trapd00r/LS_COLORS
zinit ice wait lucid atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

# Prefer hstr to Ctrl-R history search widget at https://github.com/zdharma/history-search-multi-word : compile'{hsmw-*,test/*}' zdharma/history-search-multi-word
# https://github.com/dvorka/hstr/blob/master/CONFIGURATION.md#zsh-emacs-keymap
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)

# zsh-autosuggestions - fish-like fast/unobtrusive autosuggestions - https://github.com/zsh-users/zsh-autosuggestions#configurations
# fast-syntax-highlighting - zdhara has better / faster syntax highlighting than zsh-users/zsh-syntax-highlighting
# zsh-history-substring-search - history search feature, type and part of command and use up/down arrows - https://github.com/zsh-users/zsh-history-substring-search
# asdf - use completions that ship with tool, OMZ plugin is broken - https://github.com/ohmyzsh/ohmyzsh/pull/8538
# dirhistory - alt+arrow keyboard shortcuts for navigating directory hierarchy / history
# fzf - cross-platform completions for **<tab>
# DISABLE_FZF_KEY_BINDINGS prevents fzf plugin from taking over ctrl-i, ctrl-r, ctrl-t, esc c as ctrl-r should be hstr
# jump - jump, mark, unmark, marks and Ctrl-G
# rake-fast - fast rake autocompletion, adds rake_refresh function
# ssh-agent - starts ssh-agent up
# sudo - hit ESC twice to sudo prefix prior command
# safe-paste - review code after pasting
# web-search (requires OMZ open_command) - web_search google / bing / yahoo / github / ddg / stackoverflow
zinit wait"1" lucid light-mode for \
    atload'!_zsh_autosuggest_start' \
  zsh-users/zsh-autosuggestions \
    atinit"typeset -g ZSH_AUTOSUGGEST_USE_ASYNC; ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
  zdharma/fast-syntax-highlighting \
    atload"bindkey '^[[A' history-substring-search-up; \
         bindkey '^[[B' history-substring-search-down" \
  zsh-users/zsh-history-substring-search \
  atload"source etc/bash_completion.d/asdf.bash" $(brew --prefix asdf) \
  OMZ::plugins/dirhistory/dirhistory.plugin.zsh \
  atinit'typeset -g DISABLE_FZF_KEY_BINDINGS=true' OMZ::plugins/fzf/fzf.plugin.zsh \
  OMZ::plugins/jump/jump.plugin.zsh \
  OMZ::plugins/rake-fast/rake-fast.plugin.zsh \
    atload"zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa-jenkins; \
    zstyle :omz:plugins:ssh-agent lifetime 2h" \
  OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh \
  OMZ::plugins/sudo/sudo.plugin.zsh
# OMZ::plugins/web-search/web-search.plugin.zsh
# OMZ::plugins/safe-paste/safe-paste.plugin.zsh

# build OSX list of run + autocompleted list of possible apps - alfred already does similar things
if [ "`uname`" = "Darwin" ]; then
  compctl -f -x 'p[2]' -s "`/bin/ls -d1 /Applications/*/*.app /Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`" -- open
  alias run='open -a'
fi
