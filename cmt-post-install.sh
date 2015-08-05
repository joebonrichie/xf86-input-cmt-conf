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
}

install() {
    # Symlink to right place for Arch Linux
    ln -sf /usr/share/xf86-input-cmt/20-mouse.conf /etc/X11/xorg.conf.d/20-mouse.conf
    ln -sf /usr/share/xf86-input-cmt/20-touchscreen.conf /etc/X11/xorg.conf.d/20-touchscreen.conf
    ln -sf /usr/share/xf86-input-cmt/40-touchpad-cmt.conf /etc/X11/xorg.conf.d/40-touchpad-cmt.conf

    # Symlink model specific .conf file
    case $model in
    Aebl)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-aebl.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-aebl.conf
      ;;
    Alex)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-alex.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-alex.conf
      ;;
    Banjo)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-banjo.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-banjo.conf
      ;;
    Butterfly)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-butterfly.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-butterfly.conf
      ;;
    Candy)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-candy.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-candy.conf
      ;;
    Clapper)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-clapper.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-clapper.conf
      ;;
    Daisy)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-daisy.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-daisy.conf
      ;;
    Elan)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-elan.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-elan.conf
      ;;
    Enguarde)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-enguarde.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-enguarde.conf
      ;;
    Expresso)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-expresso.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-expresso.conf
      ;;
    Falco)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-falco.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-falco.conf
      ;;
    Glimmer)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-glimmer.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-glimmer.conf
      ;;
    Gnawty)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-gnawty.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-gnawty.conf
      ;;
    Kaen)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-kaen.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-kaen.conf
      ;;
    Kip)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-kip.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-kip.conf
      ;;
    Leon)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-leon.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-leon.conf
      ;;
    Link)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-link.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-link.conf
      ;;
    Lumpy)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-lumpy.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-lumpy.conf
      ;;
    Mario)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-mario.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-mario.conf
      ;;
    Parrot)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-parrot.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-parrot.conf
      ;;
    Peppy)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-peppy.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-peppy.conf
      ;;
    Pi)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-pi.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-pi.conf
      ;;
    Pit)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-pit.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-pit.conf
      ;;
    Puppy)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-puppy.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-puppy.conf
      ;;
    Quawks)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-quawks.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-quawks.conf
      ;;
    Rambi)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-rambi.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-rambi.conf
      ;;
    Samus)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-samus.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-samus.conf
      ;;
    Spring)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-spring.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-spring.conf
      ;;
    Squawks)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-squawks.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-squawks.conf
      ;;
    Stout)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-stout.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-stout.conf
      ;;
    Swanky)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-swanky.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-swanky.conf
      ;;
    Veyron)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-veyron_speedy.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-veyron_speedy.conf
      ;;
    Wolf)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-wolf.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-wolf.conf
      ;;
    Zgb)
      ln -sf /usr/share/xf86-input-cmt/50-touchpad-cmt-zgb.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-zgb.conf
      ;;
    *)
       note "Can't detect your device, not installing device specific configuration file"
       note "See /usr/share/xf86-input-cmt/README for more information"
       exit 1
       ;;
    esac

    msg_blue "Adding user to input group"
    usermod -a -G input $USER

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
