#!/bin/bash

function dept() {
  local dep=$(echo "$rollno" | cut -c 2-3)
  case $dep in
    06) department="CSE" ;;
    02) department="CHE" ;;
    03) department="CIV" ;;
    07) department="EEE" ;;
    08) department="ECE" ;;
    10) department="ICE" ;;
    11) department="MEC" ;;
    12) department="MME" ;;
    14) department="PRO" ;;
    01) department="ARC" ;;
    *) echo "InvalidDept" ;;
  esac
}

function HADfile() {
  sudo dscl . -create "/Users/had"
  sudo dscl . -create "/Users/had" UserShell "/bin/bash"
  sudo dscl . -create "/Users/had" NFSHomeDirectory "/Users/had"
  sudo dscl . -passwd "/Users/had" "123"

  sudo mkdir -p "/Users/had"
  sudo touch "/Users/had/mess.txt"
  sudo chmod -R 777 "/Users/had"
  echo "Mess1: 0
Mess2: 0
Mess3: 0

Student Preferences:

" >> "/Users/had/mess.txt"
}

function hostel() {
  for i in "GarnetA" "GarnetB" "Agate" "Opal"; do
    sudo dscl . -create "/Users/$i"
    sudo dscl . -create "/Users/$i" UserShell "/bin/bash"
    sudo dscl . -create "/Users/$i" NFSHomeDirectory "/Users/$i"
    sudo dscl . -passwd "/Users/$i" "123"

    sudo mkdir -p "/Users/$i"
    sudo touch "/Users/$i/announcements.txt"
    sudo touch "/Users/$i/stayout.txt"
    sudo touch "/Users/$i/feeDefaulters.txt"
  done
}

function students() {
  while read -r line2; do
    hostel1=$(echo "$line2" | cut -d " " -f 3)
    room=$(echo "$line2" | cut -d " " -f 4)
    name=$(echo "$line2" | cut -d " " -f 1)
    sudo dscl . -create "/Users/$hostel1/$room/$name"
    sudo dscl . -create "/Users/$hostel1/$room/$name" UserShell "/bin/bash"
    sudo dscl . -create "/Users/$hostel1/$room/$name" NFSHomeDirectory "/Users/$hostel1/$room/$name"
    sudo dscl . -passwd "/Users/$hostel1/$room/$name" "123"

    sudo mkdir -p "/Users/$hostel1/$room/$name"
    sudo touch "/Users/$hostel1/$room/$name/userdetails.txt"
  done < studentDetails.txt
}

HADfile > /dev/null 2>&1

hostel > /dev/null 2>&1

students > /dev/null 2>&1

while read -r line3; do
  hostel1=$(echo "$line3" | cut -d " " -f 3)
  room=$(echo "$line3" | cut -d " " -f 4)
  name=$(echo "$line3" | cut -d " " -f 1)
  echo "Name: $name" >> "/Users/$hostel1/$room/$name/userdetails.txt"
  rollno=$(echo "$line3" | cut -d " " -f 2)
  echo "Room: $room" >> "/Users/$hostel1/$room/$name/userdetails.txt"
  echo "Rollno: $rollno" >> "/Users/$hostel1/$room/$name/userdetails.txt"
  dept
  echo "Year: First Year" >> "/Users/$hostel1/$room/$name/userdetails.txt"
  echo "Hostel: $hostel1" >> "/Users/$hostel1/$room/$name/userdetails.txt"
done < studentDetails.txt > /dev/null 2>&1
