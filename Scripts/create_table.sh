#! /bin/bash
shopt -s extglob

clear
while true; do
    read -p "Enter table name: " table
    # Check if the input contains only alphabets
    if [[ $table == +([a-zA-Z_]) ]]; then
        # Check if it's unique
        if [ ! -e "$table" ]; then
            touch "${table}-meta"
            clear
            echo -e "Please enter the number of columns in your new table."
            echo "**Note that the first column is your Primary Key**"
            sleep 3
            clear
            while true; do
                read -p "Number of columns in $table table: " columns
                # Check if the input is numeric
                if [[ $columns =~ ^[0-9]+$ ]]; then
                    clear
                    i=1
                    while [ "$i" -le "$columns" ]; do
                        read -p "Name of Column number $i: " columnName
                        # Check if the input contains only alphabets and underscores
                        if [[ $columnName == +([a-zA-Z_]) ]]; then
                            echo -n "$columnName:" >> "${table}-meta"
                            echo "Column ($i) is set to ($columnName)"
                            echo "Data type of column ($columnName): "
                            PS3="Enter 1 for int or 2 for string: "
                            select dataType in int string; do
                                case $REPLY in
                                    1)
                                        echo "Data type of column ($columnName) is set to (int)"
                                        sleep 3
                                        clear
                                        echo -e "int" >> "${table}-meta"
                                        break ;;
                                    2)
                                        echo "Data type of column ($columnName) is set to (string)"
                                        sleep 3
                                        clear
                                        echo -e "string" >> "${table}-meta"
                                        break ;;
                                    *)
                                        echo "Invalid option. Please select either 1 for int or 2 for string." ;;
                                esac
                            done
                            ((i++))
                        else
                            echo "Please enter a valid column name with alphabets and underscores only."
                        fi
                    done 
                    touch "$table"
                    clear
                    echo -e "Table created successfully!\n"
                    sleep 2
                    . ../../Scripts/DatabaseMenu.sh
                    break
                else
                    echo "Please enter a valid numeric value for the number of columns."
                fi
            done
        else
            echo "This name already exists!"
        fi
    else
        echo "Table name accepts alphabets and underscores only"
    fi
done
