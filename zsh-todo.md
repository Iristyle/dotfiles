zsh plugins to look into

zsh general notes
https://superuser.com/questions/439209/how-to-partially-disable-the-zshs-autocorrect
https://unix.stackexchange.com/questions/260563/sudo-nocorrect-command-not-found - fixing the alias sudo='sudo ' / alias sudo='nocorrect sudo'
https://github.com/zdharma/zinit-configs/blob/master/psprint/zshrc.zsh - various sample zinit configs

precmd - update iterm2 title / tab
https://github.com/scriptingosx/dotfiles/blob/master/zshfunctions/update_terminal_pwd

# reset all plugins
zinit delete --clean --all && zinit cclear && rm -f ~/.zcompdump && zinit zstatus && source ~/.zshrc && zinit compinit

# alternate LS_COLORS load / dircolors-material
# Dircolors material theme - https://github.com/zpm-zsh/dircolors-material
: zinit wait"0c" lucid reset \
 atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
        \${P}sed -i \
        '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
        \${P}dircolors -b LS_COLORS > c.zsh" \
 atpull'%atclone' pick"c.zsh" nocompile'!' \
 atload'zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}";' for \
    trapd00r/LS_COLORS

zinit wait"0c" lucid \
 atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}";' for \
    zpm-zsh/dircolors-material

# zsh-startify, a vim-startify like plugin
: zinit wait"0b" lucid atload"zsh-startify" for zdharma/zsh-startify

# direnv - unclutter your .profile / lazy-load per directory https://direnv.net/
# todo.txt-cli - a simple and extensible shell script for managing your todo.txt file - https://github.com/todotxt/todo.txt-cli / http://todotxt.org/

# z - jump around - https://github.com/rupa/z
# also an OMZ plugin at https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z
zinit ice wait blockf lucid
zinit light rupa/z
# Jump quickly to directories that you have visited "frecently." A native ZSH port of z.sh.
trigger-load'!zshz' blockf \
    agkozak/zsh-z \

# z tab completion - Cli shell plugin, the missing fuzzy tab completion feature of z jump around command. - https://github.com/changyuheng/fz
zinit ice wait lucid
zinit light changyuheng/fz

# fzf already installed - here's some more config
https://gist.github.com/wandsas/3f48ceb7d592430c8fe6341ac44ace13

# z / fzf (ctrl-g) - Plugin for zsh to integrate fzf and various 'frecency' plugins, including z.sh - enables easy switching between recent dirs in zsh
 - https://github.com/andrewferrier/fzf-z
zinit ice wait lucid
zinit light andrewferrier/fzf-z

# fzf-marks, at slot 0, for quick Ctrl-G accessibility
zinit wait lucid for \
    urbainvaes/fzf-marks

# fzy - improved version of fzf - https://github.com/jhawthorn/fzy
# fzf plugs into a lot of things - have to see if this can be easily swapped in everywhere
zinit wait"1" lucid as"program" pick"$ZPFX/bin/fzy*" \
 atclone"cp contrib/fzy-* $ZPFX/bin/" \
 make"!PREFIX=$ZPFX install" for \
    jhawthorn/fzy

# Auto-close and delete matching delimiters in zsh - https://github.com/hlissner/zsh-autopair
pick'autopair.zsh' nocompletions \
    hlissner/zsh-autopair

# Type `git open` to open the GitHub page or website for a repository in your browser. - https://github.com/paulirish/git-open

# A utility tool powered by fzf for using git interactively - https://github.com/wfxr/forgit
atinit"forgit_ignore='fgi'" wfxr/forgit
trigger-load'!ga;!gcf;!gclean;!gd;!glo;!grh;!gss' \
    wfxr/forgit \

# delta! https://github.com/dandavison/delta
# better git diffs than diff-so-fancy
# The project `diff-so-fancy` (an extension for git) as a Zsh plugin
 - zsh-diff-so-fancy - https://github.com/zdharma/zsh-diff-so-fancy / https://github.com/so-fancy/diff-so-fancy
light-mode as'null' sbin for sbin"bin/git-dsf;bin/diff-so-fancy" zdharma/zsh-diff-so-fancy

# Because your terminal should be able to perform tasks asynchronously without external tools! - https://github.com/mafredri/zsh-async
pick'async.zsh' light-mode \
        mafredri/zsh-async

# k is the new l, yo - directory listings for zsh with git features - https://github.com/supercrabtree/k

# warp directories - move to custom dirs with zsh without using cd - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/wd


# verify all the possible git improvement stuff
# OMZ gitfast plugin - 3151 lines - updated Sept 8 2019 - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/gitfast/git-completion.bash
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gitfast


# avoid constant recompilation - is this even necessary with zinit??
https://gist.github.com/ctechols/ca1035271ad134841284

# makes your touchbar more powerful - https://github.com/zsh-users/zsh-apple-touchbar


# some dotfiles to check out
# https://github.com/petobens/dotfiles
