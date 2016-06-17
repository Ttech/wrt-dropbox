#!/bin/bash -x
# set this....
MIPSGCCPATH="" # path to MIPS compiler

INSTALLOPTIONAL="1"
case "$PATH" in
	*mips*)
		echo "Mips compiler found..."
	;;
	*)
		export PATH="$PATH:$MIPSGCCPATH"
	;;
esac

### PACKAGES (don't forget trailing space)

# packages to remove
selected_packages+="-ppp -ppp-mod-pppoe -kmod-ppp -kmod-pppoe -kmod-pppox -firewall -ip6tables -kmod-nf-conntrack6 -kmod-ip6tables -kmod-ipv6 -odhcp6c "
# kernel modules to install
selected_packages+="kmod-fs-ext4 block-mount kmod-usb-storage kmod-ipt-nat kmod-ipt-conntrack kmod-ipt-conntrack-extra kmod-ipt-extra "
# actual packages we're installing...
selected_packages+="openvpn-openssl hostip ddns-scripts muninlite lsof logd "
if [ "$INSTALLOPTIONAL" -eq 1 ]; then
	selected_packages+="e2fsprogs kmod-gpio-button-hotplug "
	selected_packages+="nano screen "
fi

### BUILD ###
make clean
make image PROFILE="GL-MT300A" PACKAGES="$selected_packages" FILES=files/

 ## REPORT SIZE
echo "Final size of image is..."
du -h  ./bin/ramips/*sysupgrade*
