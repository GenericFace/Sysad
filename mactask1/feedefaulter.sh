#!/bin/bash

# printing in announcements function
function announce(){
  local count=0
  top+=("$rollno")
  ((count++))
  if [[ $count -eq 5 ]]; then
    break
  fi

  echo "Star Payers:" >> /Users/$hostel/announcements.txt
  for i in "${top[@]}"; do
    echo "$i" >> /Users/$hostel/announcements.txt
  done
}

# printing in feedefaulters function
function defaulter(){
  while read -r line3; do
    room=$(echo "$line3" | cut -d " " -f 4)
    name=$(echo "$line3" | cut -d " " -f 1)
    for stdfile in /Users/$hostel/$room/$name; do
      if [[ -d $stdfile ]]; then
        while read -r line; do
          rollno=$(echo "$line" | grep "Rollno: " | awk '{print $2}')
          if [[ -n $rollno ]]; then
            if [[ -f "$stdfile/fees.txt" ]]; then
              announce
            else
              echo "Name: $name RollNo: $rollno" >> /Users/$hostel/feeDefaulters.txt
            fi
          fi
        done < "$stdfile/userdetails.txt"
      fi
    done
  done < studentDetails.txt
}

# user authentication
if [[ $(whoami) == "GarnetA" || $(whoami) == "GarnetB" || $(whoami) == "Agate" || $(whoami) == "Opal" ]]; then
  hostel=$(whoami)
  defaulter
else
  echo "Invalid user mf"
fi
