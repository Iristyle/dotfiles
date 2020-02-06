# Mac OS X uses path_helper and /etc/paths.d to preload PATH, clear it out first
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    eval `/usr/libexec/path_helper -s`
fi

PATH="/Users/Iristyle/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/Iristyle/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/Iristyle/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/Iristyle/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/Iristyle/perl5"; export PERL_MM_OPT;
export PATH="/usr/local/sbin:$PATH"

# checks.zsh
# checks (stolen from zshuery)
if [[ $(uname) = 'Linux' ]]; then IS_LINUX=1; fi
if [[ $(uname) = 'Darwin' ]]; then IS_MAC=1; fi

# Main change, you can see directories on a dark background
# export LSCOLORS=gxfxcxdxbxegedabagacad
if [[ $IS_MAC -eq 1 ]]; then
    export CLICOLOR=1
    export LSCOLORS=exfxcxdxbxegedabagacad
fi

if [[ $IS_LINUX -eq 1 ]]; then
    #LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
    #export LS_COLORS
    eval $(dircolors -b /etc/DIR_COLORS.256color)
fi

# exports.zsh
export ZSH_TMUX_AUTOSTART="true"

# completion.zsh
# man zshcontrib
# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

# Make the list prompt friendly
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# Make the selection prompt friendly when there are a lot of choices
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Add simple colors to kill - not needed, using fzf
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# insert all expansions for expand completer - was already off, not sure what it is
# zstyle ':completion:*:expand:*' tag-order all-expansions

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

# Pretty completions
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f' # format '%B%d (errors: %e)%b'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f' # format '%B%d%b'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f' # format '%d'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # 'm:{a-z}={A-Z}' # upper case from lower case
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))' # '_*'
# zstyle ':completion:*' rehash true

# aliases.zsh
# -------------------------------------------------------------------
# use nocorrect alias to prevent auto correct from "fixing" these
# -------------------------------------------------------------------
alias sudo='nocorrect sudo'

# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

# bindkeys.zsh
# these are pulled from iTerm2 bindings for Alt-LeftArrow / Alt-RightArrow
bindkey "\e\e[D"  backward-word
bindkey "\e\e[C"  forward-word

# these bindings are not correct
bindkey '^[[1;5C' forward-word   # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word  # [Ctrl-LeftArrow]  - move backward one word

# bindkey -v   # Default to standard vi bindings, regardless of editor string

# functions.zsh
# -------------------------------------------------------------------
# any function from http://onethingwell.org/post/14669173541/any
# search for running processes
# -------------------------------------------------------------------
function any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}

# zsh_hooks.zsh - updates iTerm2 tabs / title bar
# alternative at https://github.com/scriptingosx/dotfiles/blob/master/zshfunctions/update_terminal_pwd
function precmd {
  # vcs_info
  # Put the string "hostname::/full/directory/path" in the title bar:
  echo -ne "\e]2;$PWD\a"

  # Put the parentdir/currentdir in the tab
  echo -ne "\e]1;$PWD:h:t/$PWD:t\a"
}

function set_running_app {
  printf "\e]1; $PWD:t:$(history $HISTCMD | cut -b7- ) \a"
}

function preexec {
  set_running_app
}

function postexec {
  set_running_app
}
