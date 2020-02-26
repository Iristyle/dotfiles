#!/usr/bin/env bash

# xcode tools
# ==> /usr/bin/sudo /usr/bin/xcode-select --switch /Library/Developer/CommandLineTools

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

echo "Adding taps..."

brew tap linuxkit/linuxkit
brew tap johnmccabe/vmpooler-bitbar
# for Fujitsu ix500 driver
brew tap homebrew/cask-drivers
# alternate casks, like microsoft-remote-desktop-beta
brew tap homebrew/cask-versions

echo "Installing initial packages..."
# Install a modern version of Bash, for when fallback from zsh is helpful
# Bourne-Again SHell, a UNIX command interpreter - https://www.gnu.org/software/bash/
# Programmable completion for Bash 4.1+ - https://github.com/scop/bash-completion
# Install GNU core utilities (those that come with OS X are outdated)
# GNU File, Shell, and Text utilities - https://www.gnu.org/software/coreutils
brew install bash bash-completion2 coreutils

# Switch to using brew-installed bash as default version of bash
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
fi;

CASKS=(
    #  Boosts your efficiency with hotkeys, keywords, text expansion and more - https://www.alfredapp.com/
    alfred
    # Organize your menu bar icons - https://www.macbartender.com/
    # bartender
    # Put the output from any script or program in your Mac OS X Menu Bar - https://github.com/matryer/bitbar/
    bitbar
    # e-book Management - https://calibre-ebook.com/
    # calibre
    # Just hold the ⌘-Key a bit longer to get a list of all active short cuts of the current application - https://www.mediaatelier.com/CheatSheet/
    cheatsheet
    # API documentation browser - https://kapeli.com/dash
    # dash
    # application to visually compare and merge files - https://www.sourcegear.com/diffmerge/
    diffmerge
    # https://www.docker.com/community-edition
    docker
    # https://www.microsoft.com/net/core#macos
    # dotnet
    # https://www.microsoft.com/net/core#macos
    # dotnet-sdk
    # Convert, edit, share, and collaborate on PDFs and scans in the digital workplace - https://www.abbyy.com/finereader-pro-mac-downloads/
    finereader
    # https://www.mozilla.org/firefox/
    firefox
    # ScanSnap Manager for Fujitsu ScanSnap iX500 - https://www.fujitsu.com/global/support/products/computing/peripheral/scanners/scansnap/software/ix500.html
    fujitsu-scansnap-manager-ix500
    # GNU Image Manipulation - https://www.gimp.org/
    # gimp
    # https://www.google.com/chrome/
    google-chrome
    # https://gpgtools.org/
    gpg-suite
    # tool for powerful automation of OS X - https://www.hammerspoon.org/
    hammerspoon
    # macOS Terminal Replacement - https://www.iterm2.com/
    iterm2
    # A powerful and stable keyboard customizer for macOS - https://pqrs.org/osx/karabiner/
    karabiner-elements
    # Command-line tool for creating KF8 / Mobi book files - https://www.amazon.com/gp/feature.html?docId=1000765211
    # kindlegen
    # Vim - the text editor - for macOS - https://github.com/macvim-dev/macvim
    # macvim
    # Microsoft Office - https://products.office.com/mac/microsoft-office-for-mac/
    microsoft-office
    # Microsoft Remote Desktop for Mac (App Store app) https://apps.apple.com/us/app/microsoft-remote-desktop-10/id1295203466?mt=12
    microsoft-remote-desktop-beta
    # part of the VIDEOtoolbox Suite of Applications used for the creation and editing of MP4 videos - http://www.emmgunn.com/mp4tools-home/
    # mp4tools
    # https://play.google.com/music/listen
    music-manager
    # Open Broadcaster Software - free and open source software for video recording and live streaming - https://obsproject.com/
    # obs
    # Puppet Development Kit - https://github.com/puppetlabs/pdk
    # pdk
    # https://github.com/PowerShell/PowerShell
    powershell
    # Puppet Bolt CLI tool - https://github.com/puppetlabs/bolt
    # puppet-bolt
    # https://www.qbittorrent.org/
    # qbittorrent
    # The Ruby on Rails IDE by JetBrains - https://www.jetbrains.com/ruby/
    # rubymine
    # Sned personal docs to Kindle from Mac - https://www.amazon.com/gp/sendtokindle/mac
    # send-to-kindle
    # https://slack.com/
    slack
    # Spotify music client https://www.spotify.com/
    spotify
    # Sublime text editor - https://www.sublimetext.com/3
    sublime-text
    # Open any archive in seconds - https://theunarchiver.com/
    the-unarchiver
    # free, open source graphic user interface for OpenVPN® on macOS - https://www.tunnelblick.net/
    tunnelblick
    # create bootable Live USB drives for Ubuntu and other Linux distributions without burning a CD - https://unetbootin.github.io/
    # unetbootin
    # enables users to create and configure lightweight, reproducible, and portable development environments - https://www.vagrantup.com/
    # vagrant
    # https://www.virtualbox.org/
    # virtualbox
    # free and open source cross-platform multimedia player and framework that plays most multimedia files as well as DVDs, Audio CDs, VCDs, and various streaming protocols - https://www.videolan.org/vlc/
    vlc
    # https://code.visualstudio.com/
    visual-studio-code
    # https://www.vmware.com/products/fusion.html
    vmware-fusion
    # Flexible application switching on macOS - https://manytricks.com/witch/
    witch
    # Tabs, Dual Panel and numerous features for Macs native finder - https://www.trankynam.com/xtrafinder/
    # NOTE: can't be installed due to SIP
    # xtrafinder
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Installing fonts..."
brew tap homebrew/cask-fonts
FONTS=(
    # https://www.jetbrains.com/lp/mono/
    font-jetbrainsmono-nerd-font
    # https://sourcefoundry.org/hack/
    font-hack-nerd-font-mono
    # https://github.com/tonsky/FiraCode
    font-firacode-nerd-font
    # https://github.com/adobe-fonts/source-code-pro
    font-sourcecodepro-nerd-font-mono
    # https://fontawesome.com/
    font-fontawesome
    # https://icomoon.io/
    # font-icomoon
)
brew cask install ${FONTS[@]}

echo "Installing remaining packages"

# CFT Tools List - https://github.com/ctfs/write-ups
PACKAGES=(
    # Next-generation aircrack with lots of new features - complete suite of tools to access WiFi network security - https://aircrack-ng.org/
    # aircrack-ng
    # Extendable version manager with support for Ruby, Node.js, Erlang & more - https://github.com/asdf-vm
    asdf
    # Tool for generating GNU Standards-compliant Makefiles - https://www.gnu.org/software/automake/
    # automake
    # Official Amazon AWS command-line interface - https://aws.amazon.com/cli/
    awscli
    # Clone of cat(1) with syntax highlighting and Git integration - https://github.com/sharkdp/bat
    bat
    # Remove large files or passwords from Git history like git-filter-branch - https://rtyley.github.io/bfg-repo-cleaner/
    # bfg
    # GNU binary tools for native development - https://www.gnu.org/software/binutils/binutils.html
    # binutils
    # Searches a binary image for embedded files and executable code - https://github.com/ReFirmLabs/binwalk
    # binwalk
    # Work on automating classical cipher cracking in C - https://code.google.com/p/cifer/
    # cifer
    # Diff your Docker containers - https://github.com/GoogleContainerTools/container-diff
    # container-diff
    # Reimplementation of ctags(1) - https://ctags.sourceforge.io/
    # ctags
    # Get a file from an HTTP, HTTPS or FTP server - https://curl.haxx.se/
    # OSX Catalina already has recent curl
    # curl
    # Tools to work with Android .dex and Java .class files - https://github.com/pxb1988/dex2jar
    # dex2jar
    # TCP over DNS tunnel client and server - https://packages.debian.org/sid/dns2tcp
    # dns2tcp
    # Tool for exploring each layer in a docker image - https://github.com/wagoodman/dive
    dive
    # Create Docker hosts locally and on cloud providers - https://docs.docker.com/machine
    # docker-machine
    # Convert text between DOS, UNIX, and Mac formats - https://waterlan.home.xs4all.nl/dos2unix.html
    # dos2unix
    # Functional metaprogramming aware language built on Erlang VM - https://elixir-lang.org/
    # elixir
    # Simple, fast and user-friendly alternative to find - https://github.com/sharkdp/fd
    # EXIF and IPTC metadata manipulation library and tools - https://www.exiv2.org/
    # exiv2
    # Zip password cracker - http://oldhome.schmorp.de/marc/fcrackzip.html
    # fcrackzip
    # Simple, fast and user-friendly alternative to find - https://github.com/sharkdp/fd
    fd
    # Play, record, convert, and stream audio and video - https://ffmpeg.org/
    ffmpeg
    # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed - https://www.gnu.org/software/findutils/
    # findutils
    # Console program to recover files based on their headers and footers - https://foremost.sourceforge.io/
    # foremost
    # Command-line fuzzy finder written in Go - https://github.com/junegunn/fzf
    fzf
    # Manage your Google Compute Engine resources - https://cloud.google.com/compute/docs/gcutil/
    # gcutil
    # Distributed revision control system - https://git-scm.com
    git
    # Git extension for versioning large files - https://github.com/git-lfs/git-lfs
    git-lfs
    # GitHub CLI - https://cli.github.com/
    github/gh/gh
    # Alternative to top/htop - https://nicolargo.github.io/glances/
    glances
    # GNU Pretty Good Privacy (PGP) package to enable PGP-signing commits - https://gnupg.org/
    gnupg
    # GNU implementation of the famous stream editor - https://www.gnu.org/software/sed/
    gnu-sed
    # GNU version of the tar archiving utility - https://www.gnu.org/software/tar/
    gnu-tar
    # GNU implementation of which utility - https://savannah.gnu.org/projects/which/
    # gnu-which
    # Open source programming language to build simple/reliable/efficient software - https://golang.org
    go
    # Converts/uploads GPS waypoints, tracks, and routes - https://www.gpsbabel.org/
    # gpsbabel
    # Graph visualization software from AT&T and Bell Labs - https://www.graphviz.org/
    # graphviz
    # GNU grep, egrep and fgrep - https://www.gnu.org/software/grep/
    grep
    # Interpreter for PostScript and PDF - https://www.ghostscript.com/
    # gs
    # Tool to exploit hash length extension attack - https://github.com/bwall/HashPump
    # hashpump
    # The Kubernetes package manager - https://helm.sh/
    helm
    # Bash and zsh history suggest box - https://github.com/dvorka/hstr
    hstr
    # Improved top (interactive process viewer) - https://hisham.hm/htop/
    htop
    # User-friendly cURL replacement (command-line HTTP client) - https://httpie.org/
    httpie
    # Add GitHub support to git on the command-line - https://hub.github.com/
    # hub
    # Network logon cracker which supports many services - https://github.com/vanhauser-thc/thc-hydra
    # hydra
    # Tools and libraries to manipulate images in many formats - https://www.imagemagick.org/
    # imagemagick
    # Featureful UNIX password cracker - https://www.openwall.com/john/
    # john
    # Lightweight and flexible command-line JSON processor - https://stedolan.github.io/jq/
    jq
    # Port-knock server - https://zeroflux.org/projects/knock
    # knock
    # Network authentication protocol - https://web.mit.edu/kerberos/
    # krb5
    # Kubernetes command-line interface - https://kubernetes.io/
    # NOTE: Docker for Mac also includes kubectl
    # to override the install use: brew link --overwrite kubernetes-cli
    kubernetes-cli
    # LastPass official command line interface - https://github.com/lastpass/lastpass-cli
    lastpass-cli
    # The lazier way to manage everything docker - https://github.com/jesseduffield/lazydocker
    lazydocker
    # Build tool for Clojure - https://github.com/technomancy/leiningen
    # leiningen
    # from linuxkit/linuxkit tap - Lightweight Linux distribution tool - https://github.com/linuxkit/linuxkit
    linuxkit
    # Clone of ls with colorful output, file type icons, and more - https://github.com/Peltoche/lsd
    lsd
    # Powerful, lightweight programming language - https://www.lua.org/
    # lua
    # Package manager for the Lua programming language - https://luarocks.org/
    # luarocks
    # Text-to-HTML conversion tool - https://daringfireball.net/projects/markdown/
    # markdown
    # Collection of tools that nobody wrote when UNIX was young (i.e. sponge) - https://joeyh.name/code/moreutils/
    # moreutils
    # 'traceroute' and 'ping' in a single tool - https://www.bitwizard.nl/mtr/
    mtr
    # Matroska media files manipulation tools - https://mkvtoolnix.download/
    # mkvtoolnix
    # NCurses Disk Usage - https://dev.yorhel.nl/ncdu
    ncdu
    # Net top tool grouping bandwidth per process - https://raboof.github.io/nethogs/
    nethogs
    # Netpbm is a toolkit for manipulation of graphic images, including conversion of images between a variety of different formats. There are over 300 separate tools in the package including converters for about 100 graphics format - https://netpbm.sourceforge.io/
    # netpbm
    # Port scanning utility for large networks - https://nmap.org/
    # nmap
    # Platform built on V8 to build network applications - https://nodejs.org/
    # node
    # OpenBSD freely-licensed SSH connectivity tools -https://www.openssh.com
    openssh
    # Tool for creating identical machine images for multiple platforms - https://packer.io
    # packer
    # Parallel gzip - https://zlib.net/pigz/
    pigz
    # Print info and check PNG, JNG, and MNG files - http://www.libpng.org/pub/png/apps/pngcheck.html
    # pngcheck
    # 7-Zip (high compression file archiver) implementation - https://p7zip.sourceforge.io/
    p7zip
    # Simplistic interactive filtering tool - https://github.com/peco/peco
    peco
    # Coreutils Progress Viewer - https://github.com/Xfennec/progress
    progress
    # Parse HTML at the command-line - https://github.com/EricChiang/pup
    pup
    # Monitor datas progress through a pipe - https://www.ivarch.com/programs/pv.shtml
    pv
    # Readline wrapper: adds readline support to tools that lack it - https://github.com/hanslub42/rlwrap
    # rlwrap
    # Util like xargs + awk with pattern matching support - https://github.com/lotabout/rargs
    rargs
    # Ruby version manager - https://github.com/rbenv/rbenv#readme - using asdf now
    # rbenv
    # Persistent key-value database, with built-in net interface - https://redis.io/
    # redis
    # Perl-powered file rename script with many helpful built-ins - http://plasmasturm.org/code/rename
    # rename
    # Search tool like grep and The Silver Searcher - https://github.com/BurntSushi/ripgrep
    ripgrep
    # Install various Ruby versions and implementations - https://github.com/rbenv/ruby-build
    ruby-build
    # The Rust toolchain installer - https://github.com/rust-lang/rustup.rs
    rustup
    # Terminal multiplexer with VT100/ANSI terminal emulation - https://www.gnu.org/software/screen
    screen
    # SOcket CAT: netcat on steroids -http://www.dest-unreach.org/socat/
    socat
    # Penetration testing for SQL injection and database servers - http://sqlmap.org
    # sqlmap
    # Add a public key to a remote machine's authorized_keys file - https://www.openssh.com/
    # ssh-copy-id
    # TCP flow recorder - https://github.com/simsong/tcpflow
    tcpflow
    # Replay saved tcpdump files at arbitrary speeds - https://tcpreplay.appneta.com/
    # tcpreplay
    # Analyze tcpdump output - http://www.tcptrace.org/
    # tcptrace
    # User interface to the TELNET protocol (built from macOS Sierra sources) - https://opensource.apple.com/
    # telnet
    # Send macOS User Notifications from the command-line - https://github.com/julienXX/terminal-notifier
    # terminal-notifier
    # Program that allows you to count code, quickly - https://github.com/XAMPPRocky/tokei
    tokei
    # Terminal multiplexer - https://tmux.github.io/
    tmux
    # Manage complex tmux sessions easily - https://github.com/tmuxinator/tmuxinator
    tmuxinator
    # Display directories as trees (with optional color/HTML output) - http://mama.indstate.edu/users/ice/tree/
    # lsd --tree is just as good
    # tree
    # Tools for building TCP client-server applications - https://cr.yp.to/ucspi-tcp.html
    # ucspi-tcp
    # ODBC 3 connectivity for UNIX - http://www.unixodbc.org/
    # unixodbc
    # Dynamic analysis tools (memory, debug, profiling) - https://www.valgrind.org/
    # valgrind
    # Visual Binary Diff - https://www.cjmweb.net/vbindiff/
    vbindiff
    # Vi 'workalike' with many additional features - https://www.vim.org/
    vim
    # from tap johnmccabe/vmpooler-bitbar - Manage vmpooler from your OSX menubar - https://github.com/johnmccabe/vmpooler-bitbar/
    vmpooler-bitbar
    # Internet file retriever - https://www.gnu.org/software/wget/
    # Install `wget` with IRI support.  --with-iri
    wget
    # New zlib (gzip, deflate) compatible compressor - https://github.com/google/zopfli
    zopfli
    # OSX uses zsh by default now
    # zsh
)

brew install ${PACKAGES[@]}

echo "Creating symlinks for gnu binaries in /usr/local/gnubin..."

sudo mkdir -p /usr/local/gnubin
for gnuutil in /usr/local/opt/*/libexec/gnubin/*; do
    sudo ln -sf $gnuutil /usr/local/gnubin/
done

echo "Cleaning up..."

# Remove outdated versions from the cellar.
brew cleanup

echo "Installing Ruby..."

# Ruby
asdf plugin add ruby
asdf install ruby latest
asdf global ruby $(asdf list ruby)

echo "Updating Rubygems..."
asdf exec gem update --system

echo "Installing Ruby gems"
RUBY_GEMS=(
    bundler
    pry
    pry-byebug
    pry-stack_explorer
    twig
)
asdf exec gem install ${RUBY_GEMS[@]}

# reload the shell
exec $SHELL -l
