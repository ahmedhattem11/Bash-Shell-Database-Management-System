#!/bin/bash

# Store the content of drop_table.sh
validation_script_content=$(cat ./Scripts/drop_table.sh)

# Extract the function definition
validate_function=$(echo "$validation_script_content" | sed -n '/^function validateParamName /,/^}/p')

# Execute the function definition
eval "$validate_function"

clear
while true; do
    read -p "Please enter the Database Name: " DB_Name

    # Validate the database name using the validateParamName function
    if ! validateParamName "$DB_Name"; then
        continue
    fi

    if [ -e "HNDBMS/$DB_Name" ]; then
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

