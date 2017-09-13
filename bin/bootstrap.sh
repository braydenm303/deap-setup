#! /bin/sh

# first check for internet connectivity.
# if no connection, configure wifi.
test=github.com
if nc -zw1 $test 443 && echo |openssl s_client -connect $test:443 2>&1 |awk '
	handshake && $1 == "Verification" { if ($2=="OK") exit; exit 1 }
	$1 $2 == "SSLhandshake" { handshake = 1 }'
then
	echo "Internet connection verified."
else
	echo "No internet connection."
	echo "Scanning for available networks..."
	sudo iwlist wlan0 scan | grep SSID
	read -p "Wifi name (SSID): " wifi_name
	read -p "Wifi password (PSK): " wifi_password
	wpa_passphrase "$wifi_name" "$wifi_password" | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null
	sudo wpa_cli reconfigure
fi

DEAP=/tmp/deap
wget "https://raw.githubusercontent.com/braydenm303/deap-setup/master/bin/deap" -O $DEAP
chmod +x $DEAP
$DEAP install
