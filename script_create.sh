#! /bin/bash

if [ -z "$1" ]
then
	echo "Please input name of distro..."
	exit 1
else
	DISTRONAME=$1
fi

clear
echo && echo "- Install requitments..."
sudo apt-get install debootstrap qemu-user-static

echo && echo "- Download chroot..."
sudo debootstrap --arch=arm64 $DISTRONAME debian-$DISTRONAME-arm64 http://deb.debian.org/debian/

echo && echo "Fix and compress chroot..."
sudo cp /usr/bin/qemu-aarch64-static debian-$DISTRONAME-arm64/usr/bin/
cd debian-$DISTRONAME-arm64/
sudo tar -czvf ../debian-$DISTRONAME-arm64.tar.gz *
cd ..
sudo chown $USER: debian-$DISTRONAME-arm64.tar.gz

echo && echo "- Remove chroot download..."
sudo rm -r debian-$DISTRONAME-arm64
