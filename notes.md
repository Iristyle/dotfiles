TODO: review
  move todo.zsh stuff into .zshrc
  .bash_profile
  .bash_prompt
  fzf stuff
  install delta
  figure out rspec zsh completion
  various git plugins for zsh
  review additions to .macos settings script
  powershell profile

TODO: export keychain
TODO: need to stop / restart hammerspoon for settings to take effect / plugins to download
TODO: sublime text - bootstrap install

TODO: in .secrets - import GPG keys to GPG suite
TODO: in .secrets or elsewhere - import remote desktop connections
TODO: tunnelblick - copy in cert

TODO: script out creation of vmware fusion VM for docker machine
TODO: copy all the .ssh stuff over (i..e write files from .secrets)
TODO: how to copy across the .gnupg folder??
TODO: copy over RDP connections

# Open all binary apps 1 by 1

# TODO: install microsoft office
# TODO: music-manager sign in with google account
# TODO: vmware fusion - need to enable kernel extension
# TODO: launch alfred / enter license
# TODO: log into multiple slacks
# TODO: Docker - launch enter creds
# TODO: diffmerge won't start??
# TODO: replace with beyond compare
# TODO: Add VSCode exclusion won't start / need to add exclusion
# TODO: should use vimr or onivim instead ... or macvim?
# TODO: more vim customization - install fzf + ripgrep instead of CtrlP
# TODO: switch off vim to nvim?

mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.vim

$BOLT_PASSWORD='Qu@lity!'
$os='ubuntu-1804-x86_64'
$BOLT_USER='root'

# - Chrome - sign in to both emails
# - Alfred - enter license
# - Docker - launch so that privileged networking perm can be granted

# In system prefs - security & privacy
# ====================================
# Contacts - Alfred 4
# Accessibility - Alfred 4, CheatSheet, Dash, Hammerspoon, VMWare Fusion, witchdaemon
# Full Disk Access - Alfred 4
# Automation
#   Music Manager - System Events
#   witchdaemon - Sublime Text, Microsoft Remote Desktop, iTerm, Google Chrome, System Events, Finder
# Input Monitoring - karabiner_observer, karabiner_grabber
# Kernel Extension - vmware fusion

# Puppet - maybe switch to floaty anyhow
vmpooler() {
  ~/vmpooler-client/vmpooler_client.py $*
}

# PSQL stuff
azure_extension_installs() {
  psql -h dwh-db-01-prod.ops.puppetlabs.net -U ethan fu_gooddata -c "select count(*), date_trunc('month', timestamp) from raw_dujour_checkins where \"product\" = 'azure-pe-agent' group by date_trunc('month', timestamp);"
}

azure_extension_installs_by_version(){
  psql -h dwh-db-01-prod.ops.puppetlabs.net -U ethan fu_gooddata -c "select count(*), date_trunc('month', timestamp), version from raw_dujour_checkins where \"product\" = 'azure-pe-agent' group by date_trunc('month', timestamp), version;"
}

azure_master_installs() {
  # TODO: exercise left to the reader
  psql -h dwh-db-01-prod.ops.puppetlabs.net -U ethan fu_gooddata
}


#!/usr/bin/env bash
#
# Bootstrap script for setting up a new OSX machine
#
# This should be idempotent so it can be run multiple times.
##
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

### reference -> https://gist.github.com/saetia/1623487

# TODO: in finder -- map f2 to rename files
# TODO: mosh for SSH? https://mosh.mit.edu/

# xcode - no way to automate
# TODO: must install from app store AFAIK
# must install command line tools from within xcode -> preferences -> downloads -> tools

# legit gcc compiler (not necessary in mavericks?)
# brew tap homebrew/dupes ; brew install apple-gcc42
sudo xcodebuild -license

# TODO: enable tabs, cut&paste in xtrafinder prefs
# TODO: enable backspace to go back / delete to delete things
# TODO: enable new terminal here shortcut (can change to add tab??)
# TODO: enable hide dot files on desktop
# TODO: enable return to open folder
# TODO: enable light text on dark background
# TODO: enable 'click on any item in path bar to show contents menu'

# TODO: any way to automate?
# https://itunes.apple.com/us/app/snap/id418073146?mt=12

# TODO: interactive!
wget -O/tmp/puppet.png https://si0.twimg.com/profile_images/3672925108/954f7381089ac290b4690c5ffd9dd7d3.png
bash <(curl -s https://gist.github.com/demonbane/1065791/raw/f2ebe14efe30993033ebdf90d607a98baf7c60b6/makeapp.sh)
# answer
# Puppet-Mail
# https://mail.google.com/mail/u/1/#inbox
# /tmp/puppet.png

# TODO: copy ssh key to github.com manually (could use the API)
subl ~/.ssh/id_rsa.pub

#test connection
ssh -T git@github.com

# dash (doc browser)
open https://itunes.apple.com/us/app/dash/id458034879?ls=1&mt=12
# TODO: must use app store to install, no way to automate :(
# whoa -- dash is awesome!
# useful to install dashdoc sublime text plugin to use ctrl+h to look stuff up
# TODO: verify that the binding is unused elsewhere
# can also integrate with alfred if purchasing the power pack
# can also integrate with the shell

# enable support for assistive devices


# configure witch application

# TODO: run from within sublime to setup package control
# import urllib2,os; pf='Package Control.sublime-package'; ipp = sublime.installed_packages_path(); os.makedirs( ipp ) if not os.path.exists(ipp) else None; urllib2.install_opener( urllib2.build_opener( urllib2.ProxyHandler( ))); open( os.path.join( ipp, pf), 'wb' ).write( urllib2.urlopen( 'http://sublime.wbond.net/' +pf.replace( ' ','%20' )).read()); print( 'Please restart Sublime Text to finish installation')

# TODO: turn off dumb osx non-tabbing through dialog controls by script
# http://www.macyourself.com/2009/08/22/navigate-mac-os-x-dialog-boxes-using-only-your-keyboard/

# launch tmux with each terminal session
gconftool --type string --set /apps/gnome-terminal/profiles/Default/custom_command "tmux"
gconftool --type bool --set /apps/gnome-terminal/profiles/Default/use_custom_command "true"

alias subl='/opt/homebrew-cask/Caskroom/sublime-text/2.0.2/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'



===============================================================================


To install useful keybindings and fuzzy completion:
  /usr/local/opt/fzf/install

To use fzf in Vim, add the following line to your .vimrc:
  set rtp+=/usr/local/opt/fzf


  Commands also provided by macOS have been installed with the prefix "g".
If you need to use these commands with their normal names, you
can add a "gnubin" directory to your PATH from your bashrc like:
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
Password:
/usr/local/bin/bash
Installing cask apps...
==> Downloading https://officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/Microsoft_Office_16.33.20011301_Installer.pkg
######################################################################## 100.0%
==> Verifying SHA-256 checksum for Cask 'microsoft-office'.
==> Installing Cask microsoft-office
==> Running installer for microsoft-office; your password may be necessary.
==> Package installers may write to any location; options such as --appdir are ignored.
Password:
installer: Package name is Microsoft Office
installer: Installing at base path /
installer: The install was successful.
🍺  microsoft-office was successfully installed!
==> Downloading https://rink.hockeyapp.net/api/2/apps/5e0c144289a51fca2d3bfa39ce7f2b06/app_versions/430?format=zip
==> Downloading from https://cdn.hockeyapp.net/production/app/builds/048/385/082/original/7e726d375e0172a82f291e1d1c19762a/Microsoft_Remote_Desktop_Beta.app.zip?Expires=1581050352&Signature=jW30ngfHoBAb3H3dp61VDM~lAKydOCKyYRWQEv6C5CUc~~nDfR9SjXsR1k7XENi5
######################################################################## 100.0%
==> Verifying SHA-256 checksum for Cask 'microsoft-remote-desktop-beta'.
==> Note: Running `brew update` may fix SHA-256 checksum errors.
Error: Checksum for Cask 'microsoft-remote-desktop-beta' does not match.
Expected: ab29a4f76c18b37fe2126f1ffc7ae3d8668dcb01a22af03b1f2437fd292295b1
  Actual: 848e7f4ee30224bcc921a9b1d63a24d6fda9fb55c53c0f5fb2e5208ef6c0dcb7
    File: /Users/iristyle/Library/Caches/Homebrew/downloads/62cb027a2a53115442d2b78042fdeb389d5f85abab9f25c0a475430d22ae6136--Microsoft_Remote_Desktop_Beta.app.zip
To retry an incomplete download, remove the file above.
If the issue persists, visit:
  https://github.com/Homebrew/homebrew-cask/blob/master/doc/reporting_bugs/checksum_does_not_match_error.md

==> Installing ffmpeg dependency: libffi
==> Downloading https://homebrew.bintray.com/bottles/libffi-3.2.1.catalina.bottle.tar.gz
######################################################################## 100.0%
==> Pouring libffi-3.2.1.catalina.bottle.tar.gz
==> Caveats
libffi is keg-only, which means it was not symlinked into /usr/local,
because some formulae require a newer version of libffi.

For compilers to find libffi you may need to set:
  export LDFLAGS="-L/usr/local/opt/libffi/lib"

For pkg-config to find libffi you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"

==> Summary
🍺  /usr/local/Cellar/libffi/3.2.1: 16 files, 300.7KB

==> Installing ffmpeg dependency: unbound
==> Downloading https://homebrew.bintray.com/bottles/unbound-1.9.6.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/81/813d64c350df8065b82e0ec4a057d04839c75b7e34054e9d9aec71b5b13008b1?__gda__=exp=1581047562~hmac=1452b24bd6ca37437fc94c76d1ee9fe9f01374dd7af8964925a0cf7c1dbfafae&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring unbound-1.9.6.catalina.bottle.tar.gz
==> Caveats
To have launchd start unbound now and restart at startup:
  sudo brew services start unbound
==> Summary
🍺  /usr/local/Cellar/unbound/1.9.6: 57 files, 4.9MB

==> Installing ffmpeg dependency: icu4c
==> Downloading https://homebrew.bintray.com/bottles/icu4c-64.2.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/e9/e9ae7bb5a76b48e82f56bc744eaaa1e9bdb5ca49ea6b5a2e4d52f57ad331f063?__gda__=exp=1581047588~hmac=7129d68934e35c9076c8bec9f8d165bd2275518b9bd347cd6bf192a777c3d315&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring icu4c-64.2.catalina.bottle.tar.gz
==> Caveats
icu4c is keg-only, which means it was not symlinked into /usr/local,
because macOS provides libicucore.dylib (but nothing else).

If you need to have icu4c first in your PATH run:
  echo 'export PATH="/usr/local/opt/icu4c/bin:$PATH"' >> ~/.zshrc
  echo 'export PATH="/usr/local/opt/icu4c/sbin:$PATH"' >> ~/.zshrc

For compilers to find icu4c you may need to set:
  export LDFLAGS="-L/usr/local/opt/icu4c/lib"
  export CPPFLAGS="-I/usr/local/opt/icu4c/include"

For pkg-config to find icu4c you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

==> Summary
🍺  /usr/local/Cellar/icu4c/64.2: 257 files, 69.3MB

==> Installing ffmpeg dependency: tesseract
==> Downloading https://homebrew.bintray.com/bottles/tesseract-4.1.1.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/81/81ff467946d9c85151c86819034cd183a983b4a3fa10374c7f039a5ec3ef0d82?__gda__=exp=1581047644~hmac=44aab439b2326881135e10707237c7a5f7bdec1f39ac6341bed07b451cc3d8cb&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring tesseract-4.1.1.catalina.bottle.tar.gz
==> Caveats
This formula contains only the "eng", "osd", and "snum" language data files.
If you need any other supported languages, run `brew install tesseract-lang`.
==> Summary
🍺  /usr/local/Cellar/tesseract/4.1.1: 65 files, 29.6MB

==> Downloading https://homebrew.bintray.com/bottles/git-lfs-2.10.0.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/8f/8fec7d8b8ad7c3332bfa1862dd8615712dab8315a9128ed8b5609fa1659431e7?__gda__=exp=1581047665~hmac=49fc8fb473b33614187f19901b07f0bf61cb7007e30e21d096db93d3e4315720&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring git-lfs-2.10.0.catalina.bottle.tar.gz
==> Caveats
Update your git config to finish installation:

  # Update global git config
  $ git lfs install

  # Update system git config
  $ git lfs install --system
==> Summary
🍺  /usr/local/Cellar/git-lfs/2.10.0: 63 files, 12.7MB

==> Installing gnupg
==> Downloading https://homebrew.bintray.com/bottles/gnupg-2.2.19.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/db/db2ff50cbb6d0c9da3ce2f692c96f776ba7043c8ba7bbbc5d026f1a11a008eba?__gda__=exp=1581047683~hmac=4017492ba76a153b97ca33bf55663fe501a7fc6c31e3655c8a01425ed2293564&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring gnupg-2.2.19.catalina.bottle.tar.gz
Error: The `brew link` step did not complete successfully
The formula built, but is not symlinked into /usr/local
Could not symlink bin/gpg
Target /usr/local/bin/gpg
already exists. You may want to remove it:
  rm '/usr/local/bin/gpg'

To force the link and overwrite all conflicting files:
  brew link --overwrite gnupg

To list all files that would be deleted:
  brew link --overwrite --dry-run gnupg

Possible conflicting files are:
/usr/local/bin/gpg -> /usr/local/MacGPG2/bin/gpg2
==> Summary
🍺  /usr/local/Cellar/gnupg/2.2.19: 134 files, 11.1MB
==> Downloading https://homebrew.bintray.com/bottles/gnu-sed-4.8.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/72/726be75d6d7155820b408a10e5c1a5ba1406374a7fc167af62524a4f4bbbc099?__gda__=exp=1581047686~hmac=7e17f1242acb86611d35e1214c8f31c3a50f20c03466d8ed840818934088ef16&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring gnu-sed-4.8.catalina.bottle.tar.gz
==> Caveats
GNU "sed" has been installed as "gsed".
If you need to use it as "sed", you can add a "gnubin" directory
to your PATH from your bashrc like:

    PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
==> Summary
🍺  /usr/local/Cellar/gnu-sed/4.8: 12 files, 572.2KB
==> Downloading https://homebrew.bintray.com/bottles/gnu-tar-1.32.catalina.bottle.1.tar.gz
==> Downloading from https://akamai.bintray.com/15/158cb67ea9e02435d671013b4d0d7369822758d9f7ff400ce2512a03f2f7f4e4?__gda__=exp=1581047688~hmac=51f75b153e1a53105acc2d803a37f635bdb8083b86f2909f0d859b34f5afb36e&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring gnu-tar-1.32.catalina.bottle.1.tar.gz
==> Caveats
GNU "tar" has been installed as "gtar".
If you need to use it as "tar", you can add a "gnubin" directory
to your PATH from your bashrc like:

    PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
==> Summary
🍺  /usr/local/Cellar/gnu-tar/1.32: 15 files, 1.7MB

==> Downloading https://homebrew.bintray.com/bottles/grep-3.4.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/52/52fb744dfc1f2766b41d90bc4126bc6101663d12c3e31446719ef723b7883266?__gda__=exp=1581047738~hmac=a736505b5b857283ca1f9cfd4ce565d8c7d676cbce513321c084b18433f81789&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring grep-3.4.catalina.bottle.tar.gz
==> Caveats
All commands have been installed with the prefix "g".
If you need to use these commands with their normal names, you
can add a "gnubin" directory to your PATH from your bashrc like:
  PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
==> Summary
🍺  /usr/local/Cellar/grep/3.4: 21 files, 908.2KB
==> Downloading https://homebrew.bintray.com/bottles/kubernetes-cli-1.17.2.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/6d/6d17df661d41decb333b2565d80339600b912c4912921e694ccd11c52e80cbbe?__gda__=exp=1581047739~hmac=1c3bc5ba4d62f3a1ed139cce48deaa0e31ec9e3039f7b7a1da76575029b6c081&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring kubernetes-cli-1.17.2.catalina.bottle.tar.gz
Error: The `brew link` step did not complete successfully
The formula built, but is not symlinked into /usr/local
Could not symlink bin/kubectl
Target /usr/local/bin/kubectl
already exists. You may want to remove it:
  rm '/usr/local/bin/kubectl'

To force the link and overwrite all conflicting files:
  brew link --overwrite kubernetes-cli

To list all files that would be deleted:
  brew link --overwrite --dry-run kubernetes-cli

Possible conflicting files are:
/usr/local/bin/kubectl -> /Applications/Docker.app/Contents/Resources/bin/kubectl
==> Caveats
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> Summary
🍺  /usr/local/Cellar/kubernetes-cli/1.17.2: 235 files, 49MB
==> Installing dependencies for lastpass-cli: curl
==> Installing lastpass-cli dependency: curl
==> Downloading https://homebrew.bintray.com/bottles/curl-7.68.0.catalina.bottle.tar.gz
Already downloaded: /Users/iristyle/Library/Caches/Homebrew/downloads/13e21088fdb8831d2cfcd605d3ef8b500b7414ca882462b0a94716421be3f7ca--curl-7.68.0.catalina.bottle.tar.gz
==> Pouring curl-7.68.0.catalina.bottle.tar.gz
==> Caveats
curl is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have curl first in your PATH run:
  echo 'export PATH="/usr/local/opt/curl/bin:$PATH"' >> ~/.zshrc

For compilers to find curl you may need to set:
  export LDFLAGS="-L/usr/local/opt/curl/lib"
  export CPPFLAGS="-I/usr/local/opt/curl/include"

For pkg-config to find curl you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/curl/lib/pkgconfig"


zsh completions have been installed to:
  /usr/local/opt/curl/share/zsh/site-functions
==> Summary
🍺  /usr/local/Cellar/curl/7.68.0: 458 files, 3.2MB
==> Installing lastpass-cli
==> Downloading https://homebrew.bintray.com/bottles/lastpass-cli-1.3.3_1.catalina.bottle.1.tar.gz
######################################################################## 100.0%
==> Pouring lastpass-cli-1.3.3_1.catalina.bottle.1.tar.gz
==> Caveats
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> Summary
🍺  /usr/local/Cellar/lastpass-cli/1.3.3_1: 10 files, 220.8KB
==> Installing linuxkit from linuxkit/linuxkit
Warning: A newer Command Line Tools release is available.
Update them from Software Update in System Preferences or
https://developer.apple.com/download/more/.

==> Downloading https://github.com/linuxkit/linuxkit/archive/v0.6.tar.gz
==> Downloading from https://codeload.github.com/linuxkit/linuxkit/tar.gz/v0.6
######################################################################## 100.0%
==> make local-build
🍺  /usr/local/Cellar/linuxkit/0.6: 8 files, 57.3MB, built in 22 seconds


==> Downloading https://homebrew.bintray.com/bottles/tmux-3.0a.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/3d/3d29caf7e2b87c9f1af575b4ec10af3e29c5de6979a8bd884153d9e8e1b69f20?__gda__=exp=1581047798~hmac=04d53563c90df5236dba475aa681a05a9747c2f7dfa03a3c5118623ad08d273e&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring tmux-3.0a.catalina.bottle.tar.gz
==> Caveats
Example configuration has been installed to:
  /usr/local/opt/tmux/share/tmux

Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> Summary
🍺  /usr/local/Cellar/tmux/3.0a: 9 files, 802.6KB
==> Installing dependencies for tmuxinator: libyaml and ruby
==> Installing tmuxinator dependency: libyaml
==> Downloading https://homebrew.bintray.com/bottles/libyaml-0.2.2.catalina.bottle.tar.gz
######################################################################## 100.0%
==> Pouring libyaml-0.2.2.catalina.bottle.tar.gz
🍺  /usr/local/Cellar/libyaml/0.2.2: 9 files, 311.3KB
==> Installing tmuxinator dependency: ruby

######################################################################## 100.0%
==> Pouring ruby-2.6.5.catalina.bottle.1.tar.gz
==> Caveats
By default, binaries installed by gem will be placed into:
  /usr/local/lib/ruby/gems/2.6.0/bin

You may want to add this to your PATH.

ruby is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have ruby first in your PATH run:
  echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc

For compilers to find ruby you may need to set:
  export LDFLAGS="-L/usr/local/opt/ruby/lib"
  export CPPFLAGS="-I/usr/local/opt/ruby/include"

For pkg-config to find ruby you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"



==> Installing vim dependency: perl
==> Downloading https://homebrew.bintray.com/bottles/perl-5.30.1.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/c6/c67104091d5328aadb95532ceb7aa4b25544c2505acd11522b5615b67953d38f?__gda__=exp=1581047836~hmac=1fb9497677a54cd024b8241d4b3d74f453a26a6ab8427b91630c15b1bde57842&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring perl-5.30.1.catalina.bottle.tar.gz
==> Caveats
By default non-brewed cpan modules are installed to the Cellar. If you wish
for your modules to persist across updates we recommend using `local::lib`.

You can set that up like this:
  PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
  echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"' >> ~/.zshrc
==> Summary
🍺  /usr/local/Cellar/perl/5.30.1: 2,442 files, 62MB
==> Installing vim
==> Downloading https://homebrew.bintray.com/bottles/vim-8.2.0200.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/cf/cf70a7dfe2cd79a2c70b71b826989d1525f345352177311b3efdd2c7d3e3bde7?__gda__=exp=1581047845~hmac=3fb7c9877736f4191051b3e326d5f3689ad5353bd305a0b6756ccb1c2ea49834&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring vim-8.2.0200.catalina.bottle.tar.gz
🍺  /usr/local/Cellar/vim/8.2.0200: 1,886 files, 32.5MB
==> Installing vmpooler-bitbar from johnmccabe/vmpooler-bitbar
==> Downloading https://github.com/johnmccabe/vmpooler-bitbar/releases/download/v2.1.1/vmpooler-bitbar.tar.gz
==> Downloading from https://github-production-release-asset-2e65be.s3.amazonaws.com/68326545/6262c8c6-9022-11e8-8063-4499cb91b99c?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20200207%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Dat
######################################################################## 100.0%
🍺  /usr/local/Cellar/vmpooler-bitbar/v2.1.1: 3 files, 11.4MB, built in 4 seconds
==> Downloading https://homebrew.bintray.com/bottles/wget-1.20.3_2.catalina.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/ef/ef65c759c5097a36323fa9c77756468649e8d1980a3a4e05695c05e39568967c?__gda__=exp=1581047855~hmac=b93fc521fe92ea15da0c79a4be93ff6fae287d5ecde26b6d695a5baaa7d372b0&response-content-disposition=attachment%3Bfil
######################################################################## 100.0%
==> Pouring wget-1.20.3_2.catalina.bottle.tar.gz
🍺  /usr/local/Cellar/wget/1.20.3_2: 50 files, 4.0MB
==> Downloading https://homebrew.bintray.com/bottles/zopfli-1.0.3.catalina.bottle.tar.gz
######################################################################## 100.0%
==> Pouring zopfli-1.0.3.catalina.bottle.tar.gz
🍺  /usr/local/Cellar/zopfli/1.0.3: 6 files, 294.2KB
==> Caveats
==> libffi
libffi is keg-only, which means it was not symlinked into /usr/local,
because some formulae require a newer version of libffi.

For compilers to find libffi you may need to set:
  export LDFLAGS="-L/usr/local/opt/libffi/lib"

For pkg-config to find libffi you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"

==> unbound
To have launchd start unbound now and restart at startup:
  sudo brew services start unbound
==> glib
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> icu4c
icu4c is keg-only, which means it was not symlinked into /usr/local,
because macOS provides libicucore.dylib (but nothing else).

If you need to have icu4c first in your PATH run:
  echo 'export PATH="/usr/local/opt/icu4c/bin:$PATH"' >> ~/.zshrc
  echo 'export PATH="/usr/local/opt/icu4c/sbin:$PATH"' >> ~/.zshrc

For compilers to find icu4c you may need to set:
  export LDFLAGS="-L/usr/local/opt/icu4c/lib"
  export CPPFLAGS="-I/usr/local/opt/icu4c/include"

For pkg-config to find icu4c you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

==> tesseract
This formula contains only the "eng", "osd", and "snum" language data files.
If you need any other supported languages, run `brew install tesseract-lang`.
==> git-lfs
Update your git config to finish installation:

  # Update global git config
  $ git lfs install

  # Update system git config
  $ git lfs install --system
==> gnu-sed
GNU "sed" has been installed as "gsed".
If you need to use it as "sed", you can add a "gnubin" directory
to your PATH from your bashrc like:

    PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
==> gnu-tar
GNU "tar" has been installed as "gtar".
If you need to use it as "tar", you can add a "gnubin" directory
to your PATH from your bashrc like:

    PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
==> grep
All commands have been installed with the prefix "g".
If you need to use these commands with their normal names, you
can add a "gnubin" directory to your PATH from your bashrc like:
  PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
==> kubernetes-cli
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> curl
curl is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have curl first in your PATH run:
  echo 'export PATH="/usr/local/opt/curl/bin:$PATH"' >> ~/.zshrc

For compilers to find curl you may need to set:
  export LDFLAGS="-L/usr/local/opt/curl/lib"
  export CPPFLAGS="-I/usr/local/opt/curl/include"

For pkg-config to find curl you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/curl/lib/pkgconfig"


zsh completions have been installed to:
  /usr/local/opt/curl/share/zsh/site-functions
==> lastpass-cli
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> mtr
mtr requires root privileges so you will need to run `sudo mtr`.
You should be certain that you trust any software you grant root privileges.
==> tmux
Example configuration has been installed to:
  /usr/local/opt/tmux/share/tmux

Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> ruby
By default, binaries installed by gem will be placed into:
  /usr/local/lib/ruby/gems/2.6.0/bin

You may want to add this to your PATH.

ruby is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have ruby first in your PATH run:
  echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc

For compilers to find ruby you may need to set:
  export LDFLAGS="-L/usr/local/opt/ruby/lib"
  export CPPFLAGS="-I/usr/local/opt/ruby/include"

For pkg-config to find ruby you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

==> tmuxinator
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> lua
You may also want luarocks:
  brew install luarocks
==> perl
By default non-brewed cpan modules are installed to the Cellar. If you wish
for your modules to persist across updates we recommend using `local::lib`.

You can set that up like this:
  PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
  echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"' >> ~/.zshrc
Creating symlinks for gnu binaries in /usr/local/gnubin...
Password:
Cleaning up...
Removing: /Users/iristyle/Library/Caches/Homebrew/go_cache... (1,473 files, 183.1MB)
Removing: /Users/iristyle/Library/Caches/Homebrew/Cask/visual-studio-code--1.41.1... (83.2MB)
Removing: /Users/iristyle/Library/Caches/Homebrew/Cask/google-chrome--79.0.3945.130.dmg... (80.3MB)
Removing: /Users/iristyle/Library/Caches/Homebrew/Cask/slack--4.2.0.zip... (69.2MB)
Removing: /Users/iristyle/Library/Caches/Homebrew/Cask/font-hack-nerd-font-mono--2.0.0.zip... (13.9MB)
Removing: /Users/iristyle/Library/Caches/Homebrew/Cask/iterm2--3.3.7.zip... (13.1MB)
Pruned 0 symbolic links and 12 directories from /usr/local
iristyle@Ethans-MacBook-Pro dotfiles %



==> Pouring readline-8.0.4.catalina.bottle.tar.gz
==> Caveats
readline is keg-only, which means it was not symlinked into /usr/local,
because macOS provides the BSD libedit library, which shadows libreadline.
In order to prevent conflicts when programs look for libreadline we are
defaulting this GNU Readline installation to keg-only.

For compilers to find readline you may need to set:
  export LDFLAGS="-L/usr/local/opt/readline/lib"
  export CPPFLAGS="-I/usr/local/opt/readline/include"

For pkg-config to find readline you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
