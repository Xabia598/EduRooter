#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Root permission needed, please turn to root/sudo user."
  exit
fi

header (){
echo -e '
▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░       


                ▓█████ ▓█████▄  █    ██  ██▀███   ▒█████   ▒█████  ▄▄▄█████▓▓█████  ██▀███  
                ▓█   ▀ ▒██▀ ██▌ ██  ▓██▒▓██ ▒ ██▒▒██▒  ██▒▒██▒  ██▒▓  ██▒ ▓▒▓█   ▀ ▓██ ▒ ██▒
                ▒███   ░██   █▌▓██  ▒██░▓██ ░▄█ ▒▒██░  ██▒▒██░  ██▒▒ ▓██░ ▒░▒███   ▓██ ░▄█ ▒
                ▒▓█  ▄ ░▓█▄   ▌▓▓█  ░██░▒██▀▀█▄  ▒██   ██░▒██   ██░░ ▓██▓ ░ ▒▓█  ▄ ▒██▀▀█▄  
                ░▒████▒░▒████▓ ▒▒█████▓ ░██▓ ▒██▒░ ████▓▒░░ ████▓▒░  ▒██▒ ░ ░▒████▒░██▓ ▒██▒
                ░░ ▒░ ░ ▒▒▓  ▒ ░▒▓▒ ▒ ▒ ░ ▒▓ ░▒▓░░ ▒░▒░▒░ ░ ▒░▒░▒░   ▒ ░░   ░░ ▒░ ░░ ▒▓ ░▒▓░
                ░ ░  ░ ░ ▒  ▒ ░░▒░ ░ ░   ░▒ ░ ▒░  ░ ▒ ▒░   ░ ▒ ▒░     ░     ░ ░  ░  ░▒ ░ ▒░
                ░    ░ ░  ░  ░░░ ░ ░   ░░   ░ ░ ░ ░ ▒  ░ ░ ░ ▒    ░         ░     ░░   ░ 
                ░  ░   ░       ░        ░         ░ ░      ░ ░              ░  ░   ░     
                ░                            
                                                       
▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░▒░                                                        
     ______     ______     ______     ______      ______     __    __        ______     __         __        
    /\  == \   /\  __ \   /\  __ \   /\__  _\    /\  ___\   /\ "-./  \      /\  __ \   /\ \       /\ \       
    \ \  __<   \ \ \/\ \  \ \ \/\ \  \/_/\ \/    \ \  __\   \ \ \-./\ \     \ \  __ \  \ \ \____  \ \ \____  
     \ \_\ \_\  \ \_____\  \ \_____\    \ \_\     \ \_____\  \ \_\ \ \_\     \ \_\ \_\  \ \_____\  \ \_____\ 
      \/_/ /_/   \/_____/   \/_____/     \/_/      \/_____/   \/_/  \/_/      \/_/\/_/   \/_____/   \/_____/ 
                                                                                                            
                                                                                                         '

}

clear

header

echo "
**************************************
* Current disk partitions:           * 
**************************************"
lsblk
echo "**************************************"

read -p "[*] Enter partition to root :: " root_partition

read -p "[*] Enter user to root (Educandoos default = usuario):: " root_user

echo "[+] Rooting..."
lsblk
rm -r temp
mkdir -p temp/kk
mount /dev/$root_partition $PWD/temp/kk 
chroot $PWD/temp/kk /usr/bin/bash 

#-- My mind cannot comprehend how this doesn't crash after 47 tries --

usr_n=$(grep -n "root	ALL=(ALL:ALL) ALL" $PWD/temp/kk/etc/sudoers | cut -d: -f1)
usr_n="$((usr_n+1))"
echo $usr_n
sed -i "${usr_n}i$root_user ALL=(ALL:ALL) ALL" $PWD/temp/kk/etc/sudoers

echo "=============================== sudoers FILE ==============================="
cat $PWD/temp/kk/etc/sudoers
echo "============================================================================"
  
lsof $PWD/temp/kk
kill -9 [PID]

umount $PWD/temp/kk
wait 1
rm -r temp

echo "[✓] Educandoos rooted, cya later!"

while true; do
    read -p "Reboot system to access Educandoos Y/N :: " yn
    case $yn in
        [Yy]* ) clear; echo "Rebooting system, see you later! <3"; header; reboot now;;
        [Nn]* ) clear; header; exit;;
        * ) echo "Please answer yes (Yy) or no (Nn).";;
    esac
done