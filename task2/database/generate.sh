#!/bin/bash

touch gammaz.sql

echo "CREATE TABLE student (
  id BIGSERIAL NOT NULL,
  hostel VARCHAR(10) NOT NULL,
  room INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  rollno INT NOT NULL
  mess INT,
);" >> ./gammaz.sql



while read line3;
    do
     hostel1=$(echo "$line3" | cut -d " " -f 3)
     room=$(echo "$line3" | cut -d " " -f 4)
     name=$(echo "$line3" | cut -d " " -f 1)
     rollno=$(echo "$line3" | cut -d " " -f 2)
     echo "INSERT INTO student (hostel, room, name, rollno) VALUES ('$hostel1', '$room', '$name', '$rollno');" >> ./gammaz.sql
    done < studentDetails.txt > /dev/null 2>&1
