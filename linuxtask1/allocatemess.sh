#!/bin/bash

# i forgot why i created it but kept it as a joke
chumma=1 

echo "Enter Name"
read name

# user aunthentication
if [[ $name == $(whoami) && $name != "had" ]]; then
  read -p "Enter Room: " room
  read -p "Enter Hostel: " hostel
  declare -A messpref #associative array cuz im quirky
  echo "Enter mess preference order (Seperated By Line)"
  for i in "FirstPref" "SecondPref" "ThirdPref"; do
    read -r pref
    messpref[$i]=$pref
    echo "$i: ${messpref[$i]}" >> /home/$hostel/$room/$name/userdetails.txt
  done
  echo "$name $room $hostel" >> /home/had/mess.txt
fi

# when hostel admin runs it + user authetication
if [[ $(whoami) == "had" ]]; then

  while IFS=: read -r key value; do
   case $key in
    Mess1*) m1=$(echo "$value" | tr -d ' ') ;;
    Mess2*) m2=$(echo "$value" | tr -d ' ') ;;
    Mess3*) m3=$(echo "$value" | tr -d ' ') ;;
   esac

   if [[ ! -z $m1 && ! -z $m2 && ! -z $m3 ]]; then
    break
   fi
  done < "/home/had/mess.txt"

  if [[ ! -z $m1 && ! -z $m2 && ! -z $m3 ]]; then
   
   name=()
   room=()
   hostel=()

   while read -r line1; do
    name+=($(echo "$line1" | cut -d " " -f 1))
    room+=($(echo "$line1" | cut -d " " -f 2))
    hostel+=($(echo "$line1" | cut -d " " -f 3))
   done < <(tail -n +8 "/home/had/mess.txt")

   len=${#name[@]}

   for ((i = 0; i < len; i++ )); do

    messpref1=()
    while read -r line2; do
      messpref1+=($(echo "$line2" | cut -d " " -f 2))
    done < <(tail -n +6 "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt")

    messpref=()

    for j in ${messpref1[@]}; do
     if [[ $j != "mess:" ]]; then
     messpref+=($j)
     fi
    done

    if [[ ${messpref[0]} -eq 1 && $m1 -lt 35 ]]; then
        echo "Allocated mess: Mess1" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
        m11=$((m1 + 1))
        sed -i "s/Mess1: $m1/Mess1: $m11/g" "/home/had/mess.txt"
       
    elif [[ $m1 -ge 35 && ${messpref[1]} -eq 2 ]]; then
        if [[ $m2 -lt 35 ]]; then
          echo "Allocated mess: Mess2" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m22=$((m2 + 1))
          sed -i "s/Mess2: $m2/Mess2: $m22/g" "/home/had/mess.txt"
          
        else 
          echo "Allocated mess: Mess3" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m33=$((m3 + 1))
          sed -i "s/Mess3: $m3/Mess3: $m33/g" "/home/had/mess.txt"
          
        fi
    elif [[ $m1 -ge 35 && ${messpref[1]} -eq 3 ]]; then
      if [[ $m3 -lt 35 ]]; then
          echo "Allocated mess: Mess3" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m33=$((m3 + 1))
          sed -i "s/Mess3: $m3/Mess3: $m33/g" "/home/had/mess.txt"
          
        else 
          echo "Allocated mess: Mess3" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m22=$((m2 + 1))
          sed -i "s/Mess2: $m2/Mess2: $m22/g" "/home/had/mess.txt"
          
        fi
    fi

    if [[ ${messpref[0]} -eq 2 && $m2 -lt 35 ]]; then
        echo "Allocated mess: Mess2" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
        m22=$((m2 + 1))
        sed -i "s/Mess2: $m2/Mess2: $m22/g" "/home/had/mess.txt"
        
    elif [[ $m2 -ge 35 && ${messpref[1]} -eq 1 ]]; then
        if [[ $m1 -lt 35 ]]; then
          echo "Allocated mess: Mess1" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m11=$((m1 + 1))
          sed -i "s/Mess1: $m1/Mess1: $m11/g" "/home/had/mess.txt"
         
        else 
          echo "Allocated mess: Mess3" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m33=$((m3 + 1))
          sed -i "s/Mess3: $m3/Mess3: $m33/g" "/home/had/mess.txt"
         
        fi
    elif [[ $m2 -ge 35 && ${messpref[1]} -eq 3 ]]; then
      if [[ $m3 -lt 35 ]]; then
          echo "Allocated mess: Mess3" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m33=$((m3 + 1))
          sed -i "s/Mess3: $m3/Mess3: $m33/g" "/home/had/mess.txt"
         
        else 
          echo "Allocated mess: Mess1" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m11=$((m1 + 1))
          sed -i "s/Mess1: $m1/Mess1: $m11/g" "/home/had/mess.txt"
         
        fi
    fi
       
    if [[ ${messpref[0]} -eq 3 && $m3 -lt 35 ]]; then
        echo "Allocated mess: Mess3" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
        m33=$((m3 + 1))
        sed -i "s/Mess3: $m3/Mess3: $m33/g" "/home/had/mess.txt"
       
    elif [[ $m3 -ge 35 && ${messpref[1]} -eq 1 ]]; then
        if [[ $m1 -lt 35 ]]; then
          echo "Allocated mess: Mess1" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m11=$((m1 + 1))
          sed -i "s/Mess1: $m1/Mess1: $m11/g" "/home/had/mess.txt"
 
        else 
          echo "Allocated mess: Mess2" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m22=$((m2 + 1))
          sed -i "s/Mess2: $m2/Mess2: $m22/g" "/home/had/mess.txt"
        fi
    elif [[ $m3 -ge 35 && ${messpref[1]} -eq 2 ]]; then
      if [[ $m2 -lt 35 ]]; then
          echo "Allocated mess: Mess2" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m22=$((m2 + 1))
          sed -i "s/Mess2: $m2/Mess2: $m22/g" "/home/had/mess.txt"
        else 
          echo "Allocated mess: Mess1" >> "/home/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m11=$((m1 + 1))
          sed -i "s/Mess1: $m1/Mess1: $m11/g" "/home/had/mess.txt"
        fi
    fi
   done
  fi
fi
