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
hash dmidecode 2>/dev/null || { note "*** This script requires that dmidecode is installed, please install it using your distro's package manager ***" 1>&2; exit 1; }

msg_blue "(Re)installing xf86-input-cmt configuration files for: "

# Determine model
model=`dmidecode |grep -m1 "Product Name:" | awk '{print $3}'`
msg_blue "Product Name: $model"

msg_blue "Getting up to date configuration files..."
# Remove old conf files
rm -f /etc/X11/xorg.conf.d/20-mouse.conf
rm -f /etc/X11/xorg.conf.d/40-touchpad-cmt.conf
# Get updated conf files
curl https://raw.githubusercontent.com/joebonrichie/xf86-input-cmt-conf/master/20-mouse.conf > /usr/share/xf86-input-cmt/20-mouse.conf
curl https://raw.githubusercontent.com/joebonrichie/xf86-input-cmt-conf/master/40-touchpad-cmt.conf > /usr/share/xf86-input-cmt/40-touchpad-cmt.conf
# Symlink to right place for Arch Linux
ln -s /usr/share/xf86-input-cmt/20-mouse.conf /etc/X11/xorg.conf.d/20-mouse.conf
ln -s /usr/share/xf86-input-cmt/40-touchpad-cmt.conf /etc/X11/xorg.conf.d/40-touchpad-cmt.conf

# Remove old conf files and resymlink. Curl tweaked conf files if they exist
case $model in
Aebl)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-aebl.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-aebl.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-aebl.conf
  ;;
Alex)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-alex.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-alex.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-alex.conf
  ;;
Butterfly)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-butterfly.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-butterfly.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-butterfly.conf
  ;;
Daisy)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-daisy.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-daisy.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-daisy.conf
  ;;
Elan)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-elan.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-elan.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-elan.conf
  ;;
Falco)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-falco.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-falco.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-falco.conf
  ;;
Kaen)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-kaen.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-kaen.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-kaen.conf
  ;;
Leon)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-leon.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-leon.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-leon.conf
  ;;
Link)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-link.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-link.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-link.conf
  ;;
Lumpy)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-lumpy.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-lumpy.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-lumpy.conf
  ;;
Mario)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-mario.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-mario.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-mario.conf
  ;;
Parrot)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-parrot.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-parrot.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-parrot.conf
  ;;
Peppy)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-peppy.conf
  curl https://raw.githubusercontent.com/joebonrichie/xf86-input-cmt-conf/master/50-touchpad-cmt-peppy.conf > /usr/share/xf86-input-cmt/50-touchpad-cmt-peppy.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-peppy.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-peppy.conf
  note "Your .conf file is already tweaked"
  ;;
Pi)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-pi.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-pi.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-pi.conf
  ;;
Pit)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-pit.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-pit.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-pit.conf
  ;;
Puppy)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-puppy.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-puppy.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-puppy.conf
  ;;
Spring)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-spring.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-spring.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-spring.conf
  ;;
Stout)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-stout.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-stout.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-stout.conf
  ;;
Wolf)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-wolf.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-wolf.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-wolf.conf
  ;;
Zgb)
  rm -f /etc/X11/xorg.conf.d/50-touchpad-cmt-zgb.conf
  ln -s /usr/share/xf86-input-cmt/50-touchpad-cmt-zgb.conf /etc/X11/xorg.conf.d/50-touchpad-cmt-zgb.conf
  ;;
*)
  note "Can't detect your device, not installing device specific configuration file"
  note "If you have a exynos, tegra or touchscreen device this may not have installed your configuration files correctly"
  note "See /usr/share/xf86-input-cmt/README for more information"
  exit 1
  ;;
esac


note "Move any existing .conf files for use with xf86-input-synaptics"
note "out of /etc/X11/xorg.conf.d/ before rebooting.\n"
msg_blue "Finished"
msg_blue "You can now delete this file and reboot to use xf86-input-cmt-xorg"
