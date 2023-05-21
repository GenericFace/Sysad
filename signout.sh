#!/bin/bash

function askperm() {
  echo "Enter the date until which you want to stay out of campus (Month DD)"
  read -r dte
  echo "$name wants to stay out of the campus until '$dte'" >> "/home/$hostel/stayout.txt"
  echo "Do you approve $name staying out (y/n): " >> "/home/$hostel/stayout.txt"
  
  touch "/home/$hostel/$room/$name/ok.txt"
  echo "$dte" >> "/home/$hostel/$room/$name/ok.txt"
}

function checkperm() {
  perm=$(grep "Do you approve" "/home/Opal/stayout.txt" | cut -d " " -f 8)


  if [[ $perm == "y" ]]; then
    if [[ -f "$file" ]]; then
      echo 'username=$(whoami)
      rd=$(last -n 1 $username | grep -v "wtmp begins" | head -n 1 | awk "{print \$5 \" \" \$6}")
      echo "$rd"
      while read -r line; do
        if [[ "$line" == "$rd" ]]; then
          echo "Welcome back!"
        else
          echo "Please consult with the warden."
          exit 1
        fi
      done < ~/ok.txt' >> ~/.bashrc
    else
      touch ~/.bashrc
      echo 'username=$(whoami)
      rd=$(last -n 3 $username | grep -v "wtmp begins" | head -n 1 | awk "{print \$5 \" \" \$6}")
      echo "$rd"
      while read -r line; do
        if [[ "$line" == "$rd" ]]; then
          echo "Welcome back!"
        else
          echo "Please consult with the warden."
          exit 1
        fi
      done < ~/ok.txt' >> ~/.bashrc
    fi
  elif [[ $perm == "n" ]]; then
    echo "Warden has rejected your request. Thank you!"
  else 
    echo "Status: Unconfirmed"
  fi

}

echo "Enter name:"
read -r name

if [[ "$(whoami)" == "$name" ]]; then
  read -p "Enter hostel: " hostel
  read -p "Enter room: " room
  echo "Do you want to stay out of the campus or do you want to check the permission (1/2)?"
  read -r ans

  case $ans in
    1) askperm ;;
    2) checkperm ;;
  esac
fi
