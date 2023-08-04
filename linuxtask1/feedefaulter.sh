#!/bin/bash

function announce(){
  local count=0
  top+=("$rollno")
  ((count++))
  if [[ $count -eq 5 ]]; then
    break
  fi

  echo "Star Payers:" >> /home/$hostel/announcements.txt
  for i in ${top[@]}; do
    echo "$i" >> /home/$hostel/announcements.txt
  done

}

function defaulter(){
  while read line3; do
   room=$(echo "$line3" | cut -d " " -f 4)
   name=$(echo "$line3" | cut -d " " -f 1)
   for stdfile in /home/$hostel/$room/$name; do
   
   if [[ -d $stdfile ]]; then
    while read line;do
      rollno=$(echo "$line" | grep "Rollno: " | awk '{print $2}')
       if [[ -n $rollno ]]; then
        if [[ -f "$stdfile/fees.txt" ]]; then
          announce
        else
          echo "Name: $name RollNo: $rollno" >> /home/$hostel/feeDefaulters.txt
        fi
       else
       	/dev/null 2>&1
       fi
    done < $stdfile/userdetails.txt
   fi
   done
  done < studentDetails.txt 
}

if [[ $(whoami) == "GarnetA" || $(whoami) == "GarnetB" || $(whoami) == "Agate" || $(whoami) == "Opal" ]]; then
  hostel=$(whoami)
  defaulter
else echo "Invalid user mf"
fi
