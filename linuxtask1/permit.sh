#!/bin/bash

sudo groupadd warden
sudo groupadd student

setfacl -R -m u:had:rwx /home
setfacl -R -m u:root:rwx /home

while read line; do
  name=$(echo "$line" | cut -d " " -f 1)
  hostel=$(echo "$line" | cut -d " " -f 3)
  room=$(echo "$line" | cut -d " " -f 4)
  
  sudo usermod -aG student $name 
  
  setfacl -m u:$name:rwx /home/$hostel/$room
  setfacl -R -m u:$name:rwx /home/$hostel/$room/$name
  
  setfacl -m u:$name:rwx /home/$hostel/$room
  setfacl -m d:u:$name:rwx /home/$hostel/$room

  setfacl -m u:$hostel:rwx /home/$hostel/$room/$name
  setfacl -m u:$hostel:rwx /home/$hostel/$room/$name/userdetails.txt
done < studentDetails.txt

for i in "GarnetA" "GarnetB" "Opal" "Agate"; do
  sudo usermod -aG warden $i
  chmod 777 /home/$i/stayout.txt
  setfacl -m g:warden:rwx /home/$i
  setfacl -R -m u:$i:rwx /home/$i
  setfacl -m u:$i:rwx /home/$i/feeDefaulters.txt
  setfacl -m u:$i:rwx /home/$i/announcements.txt
done

setfacl -m g:student:--x /home
setfacl -m g:student:--x /home/had
setfacl -m g:student:rw- /home/had/mess.txt
