#init
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y install exfat-utils exfat-fuse git wget iptables usbmount

#emby
wget https://github.com/MediaBrowser/Emby.Releases/releases/download/4.0.1.0/emby-server-deb_4.0.1.0_armhf.deb
dpkg -i emby-server-deb_4.0.1.0_arm64.deb
apt-get -f -y install
dpkg -i emby-server-deb_4.0.1.0_arm64.deb

#ads setup
mkdir /media/ads
cd /media/ads
wget https://github.com/parthgujar/random-files/raw/master/homepage%20video.mp4
sleep 30
mkdir /media/usb

#disabling systemctl for installing dnsmasq
cd 
sudo systemctl disable systemd-resolved.service
sudo systemctl stop systemd-resolved
rm /etc/resolv.conf
sudo service network-manager restart

#installing dnsmasq and configuring it 
cd /etc/
sudo apt-get install dnsmasq
wget -o https://raw.githubusercontent.com/parthgujar/Enflix_Script/master/dnsmasq.conf


#jiofi tethering
cd
cd /etc/network
wget -o https://raw.githubusercontent.com/parthgujar/Enflix_Script/master/interfaces


#port config
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8096
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
apt-get -y install iptables-persistent


reboot


 
