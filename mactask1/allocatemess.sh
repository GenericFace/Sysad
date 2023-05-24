#!/bin/bash

# i forgot why i created it but kept it as a joke
chumma=1

echo "Enter Name"
read name

# user authentication
if [[ $name == $(whoami) && $name != "had" ]]; then
  read -p "Enter Room: " room
  read -p "Enter Hostel: " hostel
  declare -A messpref # associative array cuz im quirky
  echo "Enter mess preference order (Separated By Line)"
  for i in "FirstPref" "SecondPref" "ThirdPref"; do
    read -r pref
    messpref[$i]=$pref
    echo "$i: ${messpref[$i]}" >> "/Users/Shared/$hostel/$room/$name/userdetails.txt"
  done
  echo "$name $room $hostel" >> "/Users/Shared/had/mess.txt"
fi

# when hostel admin runs it + user authentication
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
  done < "/Users/Shared/had/mess.txt"

  if [[ ! -z $m1 && ! -z $m2 && ! -z $m3 ]]; then
   
   name=()
   room=()
   hostel=()

   while read -r line1; do
    name+=($(echo "$line1" | cut -d " " -f 1))
    room+=($(echo "$line1" | cut -d " " -f 2))
    hostel+=($(echo "$line1" | cut -d " " -f 3))
   done < <(tail -n +8 "/Users/Shared/had/mess.txt")

   len=${#name[@]}

   for ((i = 0; i < len; i++ )); do

    messpref1=()
    while read -r line2; do
      messpref1+=($(echo "$line2" | cut -d " " -f 2))
    done < <(tail -n +6 "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt")

    messpref=()

    for j in ${messpref1[@]}; do
     if [[ $j != "mess:" ]]; then
     messpref+=($j)
     fi
    done

    if [[ ${messpref[0]} -eq 1 && $m1 -lt 35 ]]; then
        echo "Allocated mess: Mess1" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
        m11=$((m1 + 1))
        sed -i "" "s/Mess1: $m1/Mess1: $m11/g" "/Users/Shared/had/mess.txt"
       
    elif [[ $m1 -ge 35 && ${messpref[1]} -eq 2 ]]; then
        if [[ $m2 -lt 35 ]]; then
          echo "Allocated mess: Mess2" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m22=$((m2 + 1))
          sed -i "" "s/Mess2: $m2/Mess2: $m22/g" "/Users/Shared/had/mess.txt"
          
        else 
          echo "Allocated mess: Mess3" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m33=$((m3 + 1))
          sed -i "" "s/Mess3: $m3/Mess3: $m33/g" "/Users/Shared/had/mess.txt"
          
        fi
    elif [[ $m1 -ge 35 && ${messpref[1]} -eq 3 ]]; then
      if [[ $m3 -lt 35 ]]; then
          echo "Allocated mess: Mess3" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m33=$((m3 + 1))
          sed -i "" "s/Mess3: $m3/Mess3: $m33/g" "/Users/Shared/had/mess.txt"
          
        else 
          echo "Allocated mess: Mess3" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m22=$((m2 + 1))
          sed -i "" "s/Mess2: $m2/Mess2: $m22/g" "/Users/Shared/had/mess.txt"
          
        fi
    fi

    if [[ ${messpref[0]} -eq 2 && $m2 -lt 35 ]]; then
        echo "Allocated mess: Mess2" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
        m22=$((m2 + 1))
        sed -i "" "s/Mess2: $m2/Mess2: $m22/g" "/Users/Shared/had/mess.txt"
        
    elif [[ $m2 -ge 35 && ${messpref[1]} -eq 1 ]]; then
        if [[ $m1 -lt 35 ]]; then
          echo "Allocated mess: Mess1" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m11=$((m1 + 1))
          sed -i "" "s/Mess1: $m1/Mess1: $m11/g" "/Users/Shared/had/mess.txt"
         
        else 
          echo "Allocated mess: Mess3" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m33=$((m3 + 1))
          sed -i "" "s/Mess3: $m3/Mess3: $m33/g" "/Users/Shared/had/mess.txt"
         
        fi
    elif [[ $m2 -ge 35 && ${messpref[1]} -eq 3 ]]; then
      if [[ $m3 -lt 35 ]]; then
          echo "Allocated mess: Mess3" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m33=$((m3 + 1))
          sed -i "" "s/Mess3: $m3/Mess3: $m33/g" "/Users/Shared/had/mess.txt"
        else 
          echo "Allocated mess: Mess1" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m11=$((m1 + 1))
          sed -i "" "s/Mess1: $m1/Mess1: $m11/g" "/Users/Shared/had/mess.txt"
        fi
    fi

    if [[ ${messpref[0]} -eq 3 && $m3 -lt 35 ]]; then
        echo "Allocated mess: Mess3" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
        m33=$((m3 + 1))
        sed -i "" "s/Mess3: $m3/Mess3: $m33/g" "/Users/Shared/had/mess.txt"
        
    elif [[ $m3 -ge 35 && ${messpref[1]} -eq 1 ]]; then
        if [[ $m1 -lt 35 ]]; then
          echo "Allocated mess: Mess1" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m11=$((m1 + 1))
          sed -i "" "s/Mess1: $m1/Mess1: $m11/g" "/Users/Shared/had/mess.txt"
         
        else 
          echo "Allocated mess: Mess2" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m22=$((m2 + 1))
          sed -i "" "s/Mess2: $m2/Mess2: $m22/g" "/Users/Shared/had/mess.txt"
         
        fi
    elif [[ $m3 -ge 35 && ${messpref[1]} -eq 2 ]]; then
      if [[ $m2 -lt 35 ]]; then
          echo "Allocated mess: Mess2" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m22=$((m2 + 1))
          sed -i "" "s/Mess2: $m2/Mess2: $m22/g" "/Users/Shared/had/mess.txt"
        else 
          echo "Allocated mess: Mess1" >> "/Users/Shared/${hostel[i]}/${room[i]}/${name[i]}/userdetails.txt"
          m11=$((m1 + 1))
          sed -i "" "s/Mess1: $m1/Mess1: $m11/g" "/Users/Shared/had/mess.txt"
        fi
    fi

   done

  else
    echo "Could not find mess preferences. Please make sure the mess preferences are properly configured."
  fi

else
  echo "You are not authorized to run this script."
fi
