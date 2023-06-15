#!/bin/bash

touch ./shared/gammaz.sql

echo "CREATE TABLE studenzz (
  id BIGSERIAL NOT NULL,
  hostel VARCHAR(10) NOT NULL,
  room INTEGER NOT NULL,
  name VARCHAR(50) NOT NULL,
  year VARCHAR(10) NOT NULL,
  rollno INTEGER NOT NULL,
  messpref1 INTEGER,
  messpref2 INTEGER,
  messpref3 INTEGER,
  mess VARCHAR(10)
);" >> ./shared/gammaz.sql

while read -r line; do
   hostel=$(echo "$line" | cut -d " " -f 3)
   room=$(echo "$line" | cut -d " " -f 4)
   name=$(echo "$line" | cut -d " " -f 1)
   for stdfile in /home/$hostel/$room/$name; do
   
   if [[ -d $stdfile ]]; then
    rollno=""
    year=""
    mp1=""
    mp2=""
    mp3=""
    mess=""
    while read -r line2; do
      if [[ $line2 == "Rollno: "* ]]; then
        rollno=$(echo "$line2" | awk '{print $2}')
      elif [[ $line2 == "Year: "* ]]; then
        year=$(echo "$line2" | awk '{print $2}')
      elif [[ $line2 == "FirstPref: "* ]]; then
        mp1=$(echo "$line2" | awk '{print $2}')
      elif [[ $line2 == "SecondPref: "* ]]; then
        mp2=$(echo "$line2" | awk '{print $2}')
      elif [[ $line2 == "ThirdPref: "* ]]; then
        mp3=$(echo "$line2" | awk '{print $2}')
      elif [[ $line2 == "Allocated mess: "* ]]; then
        mess=$(echo "$line2" | awk '{print $3}')
      fi
    done < "$stdfile/userdetails.txt"

    echo "INSERT INTO studenzz (name, hostel, room, rollno, year, messpref1, messpref2, messpref3, mess) VALUES ('$name', '$hostel', '$room', '$rollno', '$year', '$mp1', '$mp2', '$mp3', '$mess');" >> ./shared/gammaz.sql
   fi
   done
done < <(tail -n +2 "studentDetails.txt" | head -n 1)
