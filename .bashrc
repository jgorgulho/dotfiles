#### ---------------------------------- ####
####     Bash Alias And Function        ####
#### ---------------------------------- ####


### ----------------------------------- ###
###      Source Global Definitions      ###
### ----------------------------------- ###

### ------------------------------- ###
###       Personal Settings         ###
### ------------------------------- ###


## --------------------------------- ##
##       Correct Path for Jekyll     ##
## --------------------------------- ##

export PATH=$PATH:/usr/local/bin

## --------------------------------- ##
##       Personal Repos Settings     ##
## --------------------------------- ##

if [ ! -f /tmp/gotdotfiles ]; then
    touch /tmp/gotdotfiles
    if [ ! -d "$HOME/.dotfiles" ]; then
        cd $HOME
        git clone "https://github.com/jgorgulho/dotfiles.git" $HOME/.dotfiles
    fi
    ~/.dotfiles/.dfm fetch origin
    if [ "$(ls -A $HOME/.tmux/plugins/tmux-resurrect)" ]; then
        ~/.dotfiles/.dfm submodule update
    else
        ~/.dotfiles/.dfm submodule init
        ~/.dotfiles/.dfm submodule update
    fi
    ~/.dotfiles/.dfm pull
    ~/.dotfiles/.dfm install
    ~/.dotfiles/.dfm umi
fi
#archey
fortune | cowsay

## --------------------------------- ##
##       Powerline Settings          ##
## --------------------------------- ##

if [ -f `which powerline-daemon` ]; then
  	powerline-daemon -q
  	POWERLINE_BASH_CONTINUATION=1
 	POWERLINE_BASH_SELECT=1
     . /usr/share/powerline/bash/powerline.sh
fi

## -------------------------------- ##
##       Personal Functions         ##
## -------------------------------- ##

# Function To Check If Package Exists
function checkPackageExists() {
    if  ! which $1 &> /dev/null; then
        packageExists=false
    else
        packageExists=true
    fi
}

# Function to change Plasma KDE5 WM from KWin to XMonad and vice versa
kdeWMCfgFile=~/.config/plasma-workspace/env/set_window_manager.sh
function toggleKDEDW(){
    if [ -f $kdeWMCfgFile ]; then
        if grep -q kwin $kdeWMCfgFile ; then
            echo "Plasmas's WM is KWin at the moment."
            read -p "Do you want to change to XMonad? " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                echo "Will change to XMonad. Please Logout..."
                echo "export KDWM=$(which xmonad)" > $kdeWMCfgFile 2> /dev/null
            else
                echo "Will NOT change to XMonad. Please continue..."
            fi
        elif grep -q xmonad $kdeWMCfgFile ; then
            echo "Plasmas's WM is XMonad at the moment."
            read -p "Do you want to change to KWin? " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                echo "Will change to KWin. Please Logout..."
                echo "export KDWM=$(which kwin)" > $kdeWMCfgFile 2> /dev/null
            else
                echo "Will NOT change to KWin. Please continue..."
            fi
        else
            echo "Sadly at the momment only supports KWin and XMonad..."
        fi
    else
        echo "The file doesn't exist. Creating a default one..."
        mkdir -p ~/.config/plasma-wokspace/env
        echo "Will change to KWin. Please Logout..."
        echo "export KDWM=$(which kwin)" > $kdeWMCfgFile 2> /dev/null
    fi

}

## ------------------------------------ ##
##       Personal GNUPG Settings        ##
## ------------------------------------ ##

# Define GNUPG Folder  
export GNUPGHOME="~/.config/gnupg"

## ---------------------------------------- ##
##       Personal Variables Settings        ##
## ---------------------------------------  ##

# Locale Settings
# export LANG="C.UTF-8"
# export LC_ALL="C.UTF-8"

# Define Main Editor  
export EDITOR=vim
VISUAL=$EDITOR
export EDITOR VISUAL

# Define Terminal Colo Support  
export TERM="screen-256color"

# Define Main Terminal
export TERMINAL=gnome-terminal

# Define Main Browser
export BROWSER=firefox

## ------------------------------------ ##
##       Personal Alias Settings        ##
## ------------------------------------ ##

# Alias for DotFiles Manager
alias dfm="~/.dotfiles/.dfm"
alias dfmi="~/.dotfiles/.dfm install"
alias dfmu="~/.dotfiles/.dfm umi"

# Source/Load ~/.bashrc Settings
alias sourceBashrc="source ~/.bashrc"

# Update ~/.bashrc Settings
alias editBashrc="$EDITOR ~/.bashrc"

# Alias ls
alias ls="ls --color --sort=extension --group-directories-first"

# Set Correct Ack
alias ack="/bin/vendor_perl/ack"

# Set rm Ask Before Removal
alias rm="rm -i"

# Set cp Ask Before Copy
alias cp="cp -i"

# Set mv Ask Before Move
alias mv="mv -i"

# Set du "Sizes In Human Readable Format"
alias du="du -h"

# Set ls Coloured
alias ls='ls --color=auto'

# -------------------------------------------------------------------------- #
#       Personal Alias Settings Needing To Check Existence Of Package        #
# -------------------------------------------------------------------------- #

packageToCheck=rsync
checkPackageExists $packageToCheck
if  [ $packageExists = true ]; then
        alias cp="rsync -iarvP"
fi

# ----------------------------------------------------- #
#       Personal Package Manager Alias Settings         #
# ----------------------------------------------------- #

# Debian
packageToCheck=apt-get
checkPackageExists $packageToCheck
if  [ $packageExists = true ]; then
    alias apt-cache="sudo apt-cache"
    alias apt-get="sudo apt-get"
    alias paci="sudo apt-get install"
    alias pacs="apt-cache search"
    alias pacr="sudo apt-get remove"
    alias packu="sudo apt-get update && sudo apt-get upgrade"
fi

# OpenSUSE
packageToCheck=zypper
checkPackageExists $packageToCheck
if  [ $packageExists = true ]; then
    alias zypper="sudo zypper"
    alias paci="sudo zypper install"
    alias pacs="zypper search"
    alias pacr="sudo zypper remove"
    alias pacu="sudo zypper update"
fi

# CentOs/RedHat Fedora <22
packageToCheck=yum
checkPackageExists $packageToCheck
if  [ $packageExists = true ]; then
    alias yum="sudo yum"
    alias paci="sudo yum install"
    alias pacs="yum search"
    alias pacu="sudo yum update"
    alias pacr="sudo yum remove"
fi

# Fedora >=22
packageToCheck=dnf
checkPackageExists $packageToCheck
if  [ $packageExists = true ]; then
    alias dnf="sudo dnf"
    alias paci="sudo dnf install"
    alias pacs="dnf search"
    alias pacu="sudo dnf update"
    alias pacr="sudo dnf remove"
fi

# Arch
packageToCheck=pacman
checkPackageExists $packageToCheck
if  [ $packageExists = true ]; then
        alias pacman="sudo pacman"
        alias pacs="yaourt -Ss"
        alias paci="yaourt --needed -S"
        alias pacu="sudo pacmatic -Syyu"
        alias pacr="sudo pacmatic -R"
        alias lock='slock'
        alias pacup="yaourt -Syyu"
        #alias pacup="~/.scripts/pacup.sh"
        alias reflector="sudo reflector -l 30 -p http --sort rate --save /etc/pacman.d/mirrorlist"
        alias wifi="sudo wifi-menu"
        # Pacmatic
fi

## -------------------------------- ##
## Docker alias and function        ##
## -------------------------------- ##

# Get latest container ID
alias dl="docker ps -l -q"
# Get container process
alias dps="docker ps"
# Get process included stop container
alias dpa="docker ps -a"
# Get images
alias di="docker images"
# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"
# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"
# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"
# Stop all containers
dstop() { docker stop $(docker ps -a -q); }
export dstop
# Remove all containers
drm() { docker rm $(docker ps -a -q); }
export drm
# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
# Remove all images
dri() { docker rmi $(docker images -q); }
export dro
# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }
export dbu
# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
export dalias
