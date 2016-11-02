#!/bin/bash

msg_blue() {
  printf "${blue}=>${bold} $1${all_off}\n"
}

note() {
  printf "${blue}=>${yellow} NOTE:${bold} $1${all_off}\n"
}

all_off="$(tput sgr0)"
bold="${all_off}$(tput bold)"
blue="${blue}$(tput setaf 4)"
yellow="${bold}$(tput setaf 3)"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   note "*** This script *MUST* be run as root. Prepend with sudo! ***" 1>&2
   exit 1
fi
# Check if dmidecode is installed
hash dmidecode 2>/dev/null || { note "*** This script requires that 'dmidecode' is installed. ***" 1>&2; exit 1; }

setup() {
msg_blue "Running post install script..."
msg_blue "(Re)installing xf86-input-cmt configuration files for: "

# Determine model
model=`dmidecode |grep -m1 "Product Name:" | awk '{print $3}'`
msg_blue "Product Name: $model"

if [ -z "model" ]
then
  exit 0
fi
}


install() {
    # Symlink to right place for Arch Linux
    ln -sf /usr/share/xf86-input-cmt/20-mouse.conf /etc/X11/xorg.conf.d/20-mouse.conf
    ln -sf /usr/share/xf86-input-cmt/20-touchscreen.conf /etc/X11/xorg.conf.d/20-touchscreen.conf
    ln -sf /usr/share/xf86-input-cmt/40-touchpad-cmt.conf /etc/X11/xorg.conf.d/40-touchpad-cmt.conf

    # Test for a config file in /usr/share/X11/xorg.conf.d
    FILE="`find /usr/share/X11/xorg.conf.d/ -name *-touchpad-cmt-$model.conf | head -1`"
    if [ "$FILE" -a -r "$FILE" ]; then
        exit 0
    fi

    # Install model specific config
    FILE="`find /usr/share/xf86-input-cmt -name *-touchpad-cmt-$model.conf | head -1`"
    if [ "$FILE" -a -r "$FILE" ]; then
        ln -sf "$FILE" /etc/X11/xorg.conf.d/
    fi
    
    #msg_blue "Adding user to input group"
    #usermod -a -G input $USER

    msg_blue "Finished setting up configuration files."
}

remove() {
    #gpasswd -d $USER input
    #msg_blue "Removed current user from input group"
    rm -f /etc/X11/xorg.conf.d/20-mouse.conf
    rm -f /etc/X11/xorg.conf.d/20-touchscreen.conf
    rm -f /etc/X11/xorg.conf.d/40-touchpad-cmt.conf
    rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-*
    rm -f /etc/X11/xorg.conf.d/60-touchpad-cmt-*
    msg_blue "xf86-input-cmt onfiguration files removed"
}

case "$1" in
    [I,i]nstall)
        setup
        install
        ;;
    [R,r]emove)
        remove
        ;;
    *)
        msg_blue "Usage: sudo cmt-post-install install|remove"
        exit 1
        ;;
     esac
