
# At this point ensure that rockpi has ethernet connected to a router with internet, power and usb only connected. 
#complete the initial setup, default password is 1234 setup new password as ghanta123
# promt will make you create a user, name him enflix, then prompt will ask for full name etc, just hit enter till it asks you a confirmation of 'y/n ?'
# once you have shell access, just execute the script


sudo -s

#init
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y install exfat-utils exfat-fuse git wget iptables usbmount autofs

#emby
wget https://github.com/MediaBrowser/Emby.Releases/releases/download/4.0.2.0/emby-server-deb_4.0.2.0_armhf.deb
dpkg -i emby-server-deb_4.0.2.0_armhf.deb
apt-get -f -y install
dpkg -i emby-server-deb_4.0.2.0_armhf.deb

#ads setup
mkdir /media/ads
cd /media/ads
wget https://github.com/parthgujar/random-files/raw/master/homepage%20video.mp4
cd 
mount /dev/sda1 /media/usb

#disabling systemctl for installing dnsmasq
cd 
sudo systemctl disable systemd-resolved.service
sudo systemctl stop systemd-resolved
rm /etc/resolv.conf
sudo service network-manager restart
sleep 30

#at this point, connect the usb dongle to the rock as well

#installing dnsmasq and configuring it 
cd /etc/
sudo apt-get -y install dnsmasq
rm -rf dnsmasq.conf
wget https://raw.githubusercontent.com/parthgujar/Enflix_Script/master/dnsmasq.conf


#jiofi tethering
cd
cd /etc/network
rm -rf interfaces
wget https://raw.githubusercontent.com/parthgujar/Enflix_Script/master/interfaces

#at this point system will go into sleep. now is a good time to connect the ethernet cable to the netgear 'ENFLIX' router. note it is imperitive to have dhcp disabled in router settings 
sleep 30

reboot

#please note, After rebooting, you need to run the following four commands

#port config
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8096
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
apt-get -y install iptables-persistent




 
