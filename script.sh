apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y install exfat-utils exfat-fuse git wget iptables usbmount
wget https://github.com/MediaBrowser/Emby.Releases/releases/download/3.5.2.0/emby-server-deb_3.5.2.0_armhf.deb
dpkg -i emby-server-deb_3.5.2.0_armhf.deb
if (( $? )); then
	apt-get -f install
	exit 1
fi
mkdir /media/ads
cd /media/ads
wget https://github.com/parthgujar/random-files/raw/master/homepage%20video.mp4
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8096
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
apt-get -y install iptables-persistent
 
