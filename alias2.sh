#!/bin/bash

sudo groupadd warden
sudo groupadd student
sudo groupadd GarnetA
sudo groupadd GarnetB
sudo groupadd Opal
sudo groupadd Agate

setfacl -R -m u:had:rwx /home

while read line; do
  name=$(echo "$line" | cut -d " " -f 1)
  hostel=$(echo "$line" | cut -d " " -f 3)
  room=$(echo "$line" | cut -d " " -f 4)
  sudo usermod -aG student $name
  sudo usermod -aG $hostel $name
  setfacl -R -m u:$hostel:rwx /home/$hostel
  setfacl -m u:$name:--- /home/$hostel/$room
  setfacl -m u:$name:rwx /home/$hostel/$room/$name
done < studentDetails.txt

for i in "GarnetA" "GarnetB" "Opal" "Agate"; do
  sudo usermod -aG warden $i
  sudo usermod -aG $i $i
  chmod 700 /home/$i
  setfacl -m g:$i:--x /home/$i
  setfacl -m g:$i:r-- /home/$i/feeDefaulters.txt
  setfacl -m g:$i:r-- /home/$i/announcements.txt
done


chmod 700 /home/had

setfacl -m g:student:--x /home/had
setfacl -m g:student:rw- /home/had/mess.txt

