#!/bin/bash

function dept(){
  local dep=$(cut --characters=2-3 <<< $rollno)
	case $dep in
		06) department="CSE";;
		02) department="CHE";;
 		03) department="CIV";;
		07) department="EEE";;
		08) department="ECE";;
		10) department="ICE";;
		11) department="MEC";;
		12) department="MME";;
		14) department="PRO";;
		01) department="ARC";;
		*) echo "InvalidDept"
	esac

}

function HADfile(){
  sudo useradd -m -s /bin/bash -d /home/had had
  sudo touch /home/had/mess.txt
  sudo chmod -R 777 /home/had
  echo "had:123" | sudo chpasswd

  echo "Mess1: 0
Mess2: 0
Mess3: 0

Student Preferences:

  " >> /home/had/mess.txt
}

function hostel(){
  for i in "GarnetA" "GarnetB" "Agate" "Opal"
  do
    sudo useradd -m -s /bin/bash -d /home/$i $i
    echo "$i:123" | sudo chpasswd
    sudo chmod -R 777 /home/$i
    sudo touch /home/$i/announcements.txt
    sudo touch /home/$i/stayout.txt
    sudo touch /home/$i/feeDefaulters.txt
  done
}


function students(){
  while read line2
  do
    hostel1=$(echo "$line2" | cut -d " " -f 3)
    room=$(echo "$line2" | cut -d " " -f 4)
    name=$(echo "$line2" | cut -d " " -f 1)
    sudo useradd -m -s /bin/bash -d /home/$hostel1/$room/$name $name
    echo "$name:123" | sudo chpasswd
    sudo chmod -R 777 /home/$hostel1/$room/$name

    sudo touch /home/$hostel1/$room/$name/userdetails.txt

  done < studentDetails.txt
}

HADfile > /dev/null 2>&1

hostel > /dev/null 2>&1

students > /dev/null 2>&1

while read line3;
    do
     hostel1=$(echo "$line3" | cut -d " " -f 3)
     room=$(echo "$line3" | cut -d " " -f 4)
     name=$(echo "$line3" | cut -d " " -f 1)
     echo "Name: $name" >> /home/$hostel1/$room/$name/userdetails.txt
     rollno=$(echo "$line3" | cut -d " " -f 2)
     echo "Room: $room" >> /home/$hostel1/$room/$name/userdetails.txt
     echo "Rollno: $rollno" >> /home/$hostel1/$room/$name/userdetails.txt
     dept
     echo "Year: First Year" >> /home/$hostel1/$room/$name/userdetails.txt
     echo "Hostel: $hostel1" >> /home/$hostel1/$room/$name/userdetails.txt
    done < studentDetails.txt > /dev/null 2>&1
