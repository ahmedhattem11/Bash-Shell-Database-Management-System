#!/bin/bash

clear
while true
do
    read -p "Please enter the Database Name: "  DB_Name

    # if string is empty
    if [ -z "$DB_Name" ]
    then
        echo "You did not enter a database name."
        continue
    fi

    if [ -e "HNDBMS/$DB_Name" ]
    then
        echo "Database already exists! Please enter a different name."
    else 
        # Create the new directory
        mkdir "HNDBMS/$DB_Name"
        echo "Database Created Successfully"
        sleep 2  # Pause for 2 seconds
        break
    fi
done
./main.sh