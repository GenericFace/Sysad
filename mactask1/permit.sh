#!/bin/bash

# creates groups
sudo dscl . -create /Groups/warden
sudo dscl . -create /Groups/student

# sets root and had the necessary perms
sudo chmod -R u=rwx,g=rwx,o=rwx /Users
sudo chmod -R u=rwx,g=rwx,o=rwx /Users/had

# sets student perms
while read -r line; do
  name=$(echo "$line" | cut -d " " -f 1)
  hostel=$(echo "$line" | cut -d " " -f 3)
  room=$(echo "$line" | cut -d " " -f 4)
  
  sudo dscl . -append /Groups/student GroupMembership "$name"
  
  sudo chmod u=--x,g=rwx,o=rwx "/Users/$hostel/$room"
  sudo chmod -R u=rwx,g=rwx,o=rwx "/Users/$hostel/$room/$name"
  
  sudo chmod u=rwx "/Users/$hostel/$room"
  sudo chmod -R "u:$name:rwx" "/Users/$hostel/$room"
  sudo chmod -R "d:u:$name:rwx" "/Users/$hostel/$room"

  sudo chmod "u:$hostel:rwx" "/Users/$hostel/$room/$name"
  sudo chmod "u:$hostel:rwx" "/Users/$hostel/$room/$name/userdetails.txt"
done < studentDetails.txt

# sets hostel perms
for i in "GarnetA" "GarnetB" "Opal" "Agate"; do
  sudo dscl . -append /Groups/warden GroupMembership "$i"
  
  sudo chmod g=--x "/Users/$i"
  sudo chmod -R u=rwx,g=rwx,o=rwx "/Users/$i"
  sudo chmod "u:$i:rwx" "/Users/$i/feeDefaulters.txt"
  sudo chmod "u:$i:rwx" "/Users/$i/announcements.txt"
done

# sets group perms (additional)
sudo chmod g=--x /Users
sudo chmod g=--x /Users/had
sudo chmod g=rw- "/Users/had/mess.txt"
