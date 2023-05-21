#!/bin/bash

declare -A feeb
feeb["TuitionFee"]=50000
feeb["HostelRent"]=20000
feeb["ServiceCharge"]=10000
feeb["MessFee"]=20000

echo -e "User Verification !!!! \nEnter your name"
read name1

if [[ $name1 == $(whoami) ]]; then
  read -p "enter name " name
  read -p "enter room " room
  read -p "enter hostel " hostel 

  echo "Welcome To The Fee Portal !!!"
  echo "This semesters total fee is Rs 1,00,000 only"
  echo "Fee Breakup:"

  for i in "${!feeb[@]}"; do
    echo "Category: $i, Amount: ${feeb[$i]}"
  done

  ime=$(date +%Y-%m-%d)
  ci=0
  ce=0

  for i in "${!feeb[@]}"; do

    if [[ -f "/home/$hostel/$room/$name/fees.txt" ]]; then

      read -p "Do you wanna pay $i (y/n)?" ans
      if [[ $ans == "y" ]]; then
       read -p "Enter amount you wanna pay" paidamount
       echo "$i: $paidamount" >> /home/$hostel/$room/$name/fees.txt
       ci=$((ci + paidamount))
      else echo "Thank you"
      fi

    else 

      touch /home/$hostel/$room/$name/fees.txt
      chmod 777 /home/$hostel/$room/$name/fees.txt

      read -p "Do you wanna pay $i (y/n)?" ans
      if [[ $ans == "y" ]]; then
       read -p "Enter amount you wanna pay" paidamount1
       echo "$i: $paidamount1" >> /home/$hostel/$room/$name/fees.txt
       ce=$((ce + paidamount1))
      else echo "Thank you"
      fi
    fi
  done

  ca=$((ci + ce))
  echo -e "\nTranscationTime: $ime" >> /home/$hostel/$room/$name/fees.txt
  echo -e "\nCummulativeAmount: $ca" >> /home/$hostel/$room/$name/fees.txt
else echo "Wrong User"
fi

    
