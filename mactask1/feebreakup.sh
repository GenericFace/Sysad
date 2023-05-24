#!/bin/bash

# again, associative array cuz im quriky
declare -A feeb
feeb["TuitionFee"]=50000
feeb["HostelRent"]=20000
feeb["ServiceCharge"]=10000
feeb["MessFee"]=20000

echo -e "User Verification !!!! \nEnter your name" #user authenticattion
read name1

if [[ $name1 == $(whoami) ]]; then
  read -p "enter name: " name
  read -p "enter room: " room
  read -p "enter hostel: " hostel 

  echo "Welcome To The Fee Portal !!!"
  echo "This semester's total fee is Rs 1,00,000 only"
  echo "Fee Breakup:"

  for i in "${!feeb[@]}"; do
    echo "Category: $i, Amount: ${feeb[$i]}"
  done

  ime=$(date +%Y-%m-%d)
  ci=0
  ce=0

  for i in "${!feeb[@]}"; do

    if [[ -f "/Users/Shared/$hostel/$room/$name/fees.txt" ]]; then

      read -p "Do you wanna pay $i (y/n)?" ans
      if [[ $ans == "y" ]]; then
       read -p "Enter amount you wanna pay: " paidamount
       echo "$i: $paidamount" >> "/Users/Shared/$hostel/$room/$name/fees.txt"
       ci=$((ci + paidamount))
      else
        echo "Thank you"
      fi

    else 

      touch "/Users/Shared/$hostel/$room/$name/fees.txt"
      chmod 777 "/Users/Shared/$hostel/$room/$name/fees.txt"

      read -p "Do you wanna pay $i (y/n)?" ans
      if [[ $ans == "y" ]]; then
       read -p "Enter amount you wanna pay: " paidamount1
       echo "$i: $paidamount1" >> "/Users/Shared/$hostel/$room/$name/fees.txt"
       ce=$((ce + paidamount1))
      else
        echo "Thank you"
      fi
    fi
  done

  ca=$((ci + ce))
  echo -e "\nTranscationTime: $ime" >> "/Users/Shared/$hostel/$room/$name/fees.txt"
  echo -e "\nCummulativeAmount: $ca" >> "/Users/Shared/$hostel/$room/$name/fees.txt"
else
  echo "Wrong User"
fi
