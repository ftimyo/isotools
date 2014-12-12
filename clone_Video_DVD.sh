#!/bin/sh
#dependencies: dvdbackup, genisoimage, espeak(if you like)
#following line not needed but gives a reminder if you forget. 
echo var_1=title
#backup dvd with dvdbackup var_1=title
dvdbackup -Mv -n "$1"
#Only there to help me keep track of the process 
date
#create .iso image with genisoimage
genisoimage -dvd-video -J -R -hfs -V "$1" -o "$1".iso $1
#Only there to help me keep track of the process 
date
#remove directory created by dvdbackup that's all now in the .iso
rm -rv $1
#uncomment and or edit the following as you please 
#only there to let me know the process finished
#echo call me rock god
#eject
#espeak "pay attention to me "$(whoami)""
