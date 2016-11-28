#### ---------------------------------- ####
####     Bash Alias And Function        ####
#### ---------------------------------- ####


### ----------------------------------- ###
###      Source Global Definitions      ###
### ----------------------------------- ###

### ------------------------------- ###
###       Personal Settings         ###
### ------------------------------- ###
if [ ! -d "$HOME/.dotfiles" ]; then
    cd $HOME
    git clone https://github.com/jgorgulho/dotfiles.git $HOME/.dotfiles
fi
~/.dotfiles/.dfm fetch
if [ "$(ls -A $HOME/.tmux/plugins/tmux-resurrect)" ]; then
    ~/.dotfiles/.dfm submodule init
else
    ~/.dotfiles/.dfm submodule update
fi
~/.dotfiles/.dfm pull
~/.dotfiles/.dfm install
~/.dotfiles/.dfm umi
archey

## --------------------------------- ##
##       Powerline Settings          ##
## --------------------------------- ##
if [ -f `which powerline-daemon` ]; then
  	powerline-daemon -q
  	POWERLINE_BASH_CONTINUATION=1
 	POWERLINE_BASH_SELECT=1
	. ~/.bin/powerline.sh
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

## ---------------------------------------- ##
##       Personal Git Repos Settings        ##
## ---------------------------------------  ##

# Define Main Repo Folder  
export MAINPERSONALGITREPO="~/hound"

# Define Backup Repo Folder  
export SECONDARYPERSONALGITREPO="~/bhound"

## ------------------------------------ ##
##       Personal GNUPG Settings        ##
## ------------------------------------ ##

# Define GNUPG Folder  
export GNUPGHOME="~/.config/gnupg"

## ---------------------------------------- ##
##       Personal Variables Settings        ##
## ---------------------------------------  ##

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
    alias pacs="sudo apt-cache search"
    alias pacr="sudo apt-get remove"
    alias packu="sudo apt-get update && sudo apt-get upgrade"
fi

# OpenSUSE
packageToCheck=zypper
checkPackageExists $packageToCheck
if  [ $packageExists = true ]; then
    alias zypper="sudo zypper"
    alias paci="sudo zypper install"
    alias pacs="sudo zypper search"
    alias pacr="sudo zypper remove"
    alias pacu="sudo zypper update"
fi

# CentOs/RedHat Fedora <22
packageToCheck=yum
checkPackageExists $packageToCheck
if  [ $packageExists = true ]; then
    alias yum="sudo yum"
    alias paci="sudo yum install"
    alias pacs="sudo yum search"
    alias pacu="sudo yum update"
    alias pacr="sudo yum remove"
fi

# Fedora >=22
packageToCheck=dnf
checkPackageExists $packageToCheck
if  [ $packageExists = true ]; then
    alias dnf="sudo dnf"
    alias paci="sudo dnf install"
    alias pacs="sudo dnf search"
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
        export warn_time="86400"  # (seconds)
        export rss_feed="https://www.archlinux.org/feeds/news/"
        export log_file="/var/log/arch-news.log"
        export pacdiff_program="pacdiff"
        export pacman_program="pacman"
        export mail_list="https://lists.archlinux.org/pipermail/arch-general/2015-January.txt.gz"
        export pacman_log="/var/log/pacman.log"
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
