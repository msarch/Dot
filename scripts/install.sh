#!/bin/bash

# debian / openbox post install script
# before running:
#     - verify paths
#     - comment / uncomment installations as needed

# for apt to access external repos edit with sudo vi and remove cdrom line from :
#   /etc/apt/sources.list. 


# ------------------------------------------------------------------------------
APT () {
    # for apt to access external repos edit with sudo vi and remove cdrom line from :
    #   /etc/apt/sources.list 
    # SED :To remove the line and print the output to standard out:
    #
    #   sed '/pattern to match/d' ./infile
    #
    # To directly modify the file – does not work with BSD sed:
    #
    #   sed -i '/pattern to match/d' ./infile

    sed -i '/cdrom/d' /etc/apt/sources.list

    # add iwlwifi repos
    echo "deb http://deb.debian.org/debian buster main contrib non-free" >> /etc/apt/sources.list
    echo "deb-src http://deb.debian.org/debian buster main contrib non-free" >> /etc/apt/sources.list

    echo "deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free" >> /etc/apt/sources.list
    echo "deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free" >> /etc/apt/sources.list

    echo "deb http://deb.debian.org/debian buster-updates main contrib non-free" >> /etc/apt/sources.list
    echo "deb-src http://deb.debian.org/debian buster-updates main contrib non-free" >> /etc/apt/sources.list

    apt update
    apt upgrade -y
}


# ------------------------------------------------------------------------------
AWESOME (){
    apt install -y awesome
    apt install -y feh # to set awesome wallpaper
    apt install -y awesome-extra
    # install Lain :
    cd ~/.config/awesome/
    git clone https://github.com/copycat-killer/lain.git
    mkdir ~/.config/awesome/
    cp /etc/xdg/awesome/rc.lua ~/.config/awesome/rc.lua
}


# ------------------------------------------------------------------------------
BASE () {
    echo "*** base apps"
    apt install -y git    # should be done already 
    apt install bash-completion
    apt install -y  mpv
    #TODO ./mpv.sh
    apt install -y  ranger
    apt install -y mc
    #apt install -y  scite
    apt install -y  tmux
    apt install -y vim                        # VIM 
    apt install -y ack                                       # VIM search
    apt install -y wget 
    #TODO ./ncmpcpp.sh
    # utilities
    apt install -y gparted
    apt install -y rsync
    apt install -y w3m
    apt install -y w3m-img 
    #apt install -y wkhtmltox            # html page to pdf conversion
    #youtube dl      TODO
    #youtube dl config TODO
    }


# ------------------------------------------------------------------------------
BLUETOOTH () {
    # BLUETOOTH USELESS FOR POP-OS
    apt install -y blueman              # bluetooth
    apt install -y bluetooth            # bluetooth
    apt install -y bluez                # bluetooth
    apt install -y bluez-tools          # bluetooth
    apt install -y rfkill               # bluetooth
}


# ------------------------------------------------------------------------------
CLEAN(){
    apt upgrade -y --fix-missing
    apt autoremove -y
}


# ------------------------------------------------------------------------------
DEV () {
    apt install -y astyle
    apt install -y bcpp
    apt install -y dialog           #ncurses
    apt install -y git-core
    apt install -y libncurses5-dev  #ncurses
    apt install -y libncursesw5-dev #ncurses
    apt install -y python-autopep8
    # METAPOST etc
    apt install -y texlive-metapost
    apt install -y context
    apt install -y gifsicle
    # pyglet is installable from PyPI:
    pip install pyglet

    #ASCIIDOC is installable from ruby
    #gem_install asciidoc
    #gem_install "asciidoctor-pdf --pre"
    #gem_install rouge
    #gem_install pygments.rb
    #gem_install coderay  #code highlighting for asciidoc
}


# ------------------------------------------------------------------------------
DOTFILES () {
    DOTFILES="~/Dotfiles"
    ln -sf $DOTFILES/dot/bashrc ~/.bashrc
    ln -sf $DOTFILES/dot/profile ~/.profile
    ln -sf $DOTFILES/dot/bash_aliases ~/.bash_aliases
    ln -sf $DOTFILES/dot/bash_functions ~/.bash_functions
    ln -sf $DOTFILES/dot/Xresources ~/.Xresources
    ln -sf $DOTFILES/dot/Xresources_dark ~/.Xresources_dark
    ln -sf $DOTFILES/dot/Xresources_light ~/.Xresources_light
    ln -sf $DOTFILES/dot/Xresources_molokai ~/.Xresources_molokai
    ln -sf $DOTFILES/ranger/dot-config-ranger ~/.config/ranger    # RANGER config
    ln -sf $DOTFILES/tmux/tmux.conf ~/.tmux.conf                   # TMUX config
    mkdir -p ~/.vim                                               # VIM config
    ln -sf $DOTFILES/vim/dot-vim ~/.vim                      # VIM config
    cd /usr/share/vim/vim81/colors/                               # VIM remove all colors except default.vim
    find . ! -name 'default.vim' -type f -exec rm -f {} +    # VIM config
    #ln -sf $DOTFILES/geany/           # TODO
}


# ------------------------------------------------------------------------------
DROPBOX () {
    apt install -y $APPS_DIR/dropbox/dropbox* && echo "installed : dropbox" >> ~/log  ||  echo "failed : dropbox" >> ~/log
    dropbox autostart y
    dropbox start -i
}


# ------------------------------------------------------------------------------
GUI (){
    apt install -y nemo           # .........FILE BROWSER
    apt install -y file-roller
    apt install -y rofi
    apt install -y firefox-esr
    apt install -y catfish        # ......... FILE SEARCH  
    # ROFI config TODO
    # apt install -y polybar 
    # polybar config TODO
    apt install -y vim-gtk3
    apt install -y fonts-inconsolata        # VIM font
    apt install -y geany
    apt install -y geary        # .......... EMAIL client
    #apt install -y jgmenu        # TODO
    #apt install -y plank         # TODO
    apt install -y xfce4-terminal # TODO

    apt install -y inkscape     #--------- GRAPHICS Vector editor
    apt install -y nomacs       #--------- GRAPHICS image viewer
    apt install -y krita        #--------- GRAPHICS Image editor
    apt install -y scribus      #--------- GRAPHICS Xpress like
    # TODO QCAD                 #--------- GRAPHICS 2d cad
    apt install -y qbittorrent  #--------- INTERNET
    # TODO skype
    #apt install -y lollypop    #--------- MEDIA music mp3 tagging
    apt install -y mcomix       #--------- MEDIA cbr comix reader
    apt install -y totem        #--------- MEDIA video streamer
    apt install -y codeblocks   #----------DEV code::blocks gui app
}


# ------------------------------------------------------------------------------
HELP(){
    echo "this script must be called with one of following arguments:\n"
    echo "   APT ........... add extra repos, remove cd rom install" 
    echo "   AWESOME ....... awesome WM"
    echo "   BASE .......... basic CLI utilities" 
    echo "   BLUETOOTH" .... bluetooth utilities
    echo "   CLEAN ......... run this when done"
    echo "   DEV"
    echo "   DOTFILES" 
    echo "   DROPBOX"
    echo "   GUI ............ GUI apps, run 'XORG' first"
    echo "   HELP ........... print this text" 
    echo "   PROCESSING"
    echo "   QCAD"  
    echo "   TMUX" 
    echo "   WIFI ........... run 'APT' first for non free drivers repos" 
    echo "   XORG ........... X"
    echo "ex:"
    echo "sudo install.sh DOTFILES"
}


# ------------------------------------------------------------------------------
#POWER () {
# hibernate
# battery
#}


# ------------------------------------------------------------------------------
# PROCESSING () {#TODO
#
#}


# ------------------------------------------------------------------------------
QCAD () { #TODO
    ln -sf $QCAD_DOTFILES/dot-config-QCAD/QCAD3.conf ~/.config/QCAD/
    ln -sf $APPS_DIR/qcad/qcad /usr/local/bin/qcad
    ln -sf $QCAD_DOTFILES/usr-share-applications/Qcad /usr/share/applications/Qcad
}


# ------------------------------------------------------------------------------
TMUX () {
    if [ -d "$TMUX_CONFIGDIR/" ]; # Check if $TMUX_CONFIGDIR exists.
    then
      echo "$TMUX_CONFIGDIR exists, it will be moved to $TMUX_CONFIGDIR.previous"
      mv "$TMUX_CONFIGDIR" "$TMUX_CONFIGDIR.previous"
    fi
    ln -s "$TMUX_DOTFILES" "$TMUX_CONFIGDIR"  # link dotfile dir to config dir
}


# ------------------------------------------------------------------------------
WIFI(){
    apt install -y firmware-iwlwifi
    apt install -y network-manager
    # sudo iwconfig for info
    # nmtui graphical config for nm
}


# ------------------------------------------------------------------------------
XORG (){
    apt install -y xorg                 # install X11       
    cp /etc/X11/xinit/xinitrc ~/.xinitrc  # create user’s “~/.xinitrc” file
    apt install x11-xserver-utils     # install XRANDR
}


# ------------------------------------------------------------------------------
ALL (){
    HELP
    HELP
    }


# ------------------------------------------------------------------------------
#                           EXTERNAL FUNCTION CALL
# ------------------------------------------------------------------------------

case "$1" in
    "") HELP;;
    ALL) "$@"; exit;;    
    APT) "$@"; exit;;
    AWESOME) "$@"; exit;; 
    BASE) "$@"; exit;;
    BLUETOOTH) "$@"; exit;;
    CLEAN) "$@"; exit;;
    DEV) "$@"; exit;;
    DOTFILES) "$@"; exit;;
    DROPBOX) "$@"; exit;;
    GUI) "$@"; exit;;
    HELP) "$@"; exit;;
    POWER) "$@"; exit;;
    PROCESSING) "$@"; exit;;
    TMUX) "$@"; exit;;
    WIFI) "$@"; exit;;
    XORG) "$@"; exit;;
    *) echo "Unkown function: $1()"; HELP; exit 2;;
esac


# How the case statement handles external function calls works.
# 
# When we call a function using the command ./myScript.sh function_name argument, 
# the function_name becomes the first argument of the script. 
# Therefore, we can check the “$1” variable in the case statement:
# 
#     “”) ;; 
# 
# If the $1 argument is empty, it’s a normal execution of the script instead
# of an external function call. Therefore, we continue the execution beyond 
# the case statement
# 
#     TEST) “$@”; exit;;
# 
# If a function name matches, we call the matched function with all arguments 
# and exit the execution after the function execution
# 
#     *) echo “Unkown function: $1()”; exit 2;; 
# 
# If we cannot find a matched function name, we think the caller attempted 
# to call an invalid function. Therefore, we print the error log and exit

