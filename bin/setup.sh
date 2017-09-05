#!/bin/sh

# A hash at the beginning of a line means it is a comment.
# Comments do not need to be typed, and they do not run when used in a script.

# configure for US
# sudo raspi-config
# set locale to "en_US.UTF-8"
# set timezone
# set keyboard layout to "Generic 104-key PC" and "English (US)"
# set wifi country to "US"
# reboot

# update the list of available software
sudo apt-get update

# apply any software updates
sudo apt-get upgrade -y

# apply any system updates
sudo apt-get dist-upgrade -y

# clean up after ourselves
sudo apt-get clean

# install the graphic interfaces
sudo apt-get install -y xserver-xorg xinit raspberrypi-ui-mods gvfs

# install applications
sudo apt-get install -y lxterminal qjackctl zynaddsubfx
# TODO: check if enabling Jack realtime system priority is what is causing deadlock

# install pure data
# download package
PD_VERSION="2.2.3"
wget 'https://github.com/agraef/purr-data/releases/download/'"$PD_VERSION"'/pd-l2ork-'"$PD_VERSION"'-raspbian-armv7l.deb' -O /tmp/pd-l2ork.deb
# install package
sudo dpkg -i /tmp/pd-l2ork.deb
# fix unmet dependencies
sudo apt-get -f install
# install other dependencies
sudo apt-get install -y libnss3 libgconf2-4

# reboot into graphic interface
sudo reboot
