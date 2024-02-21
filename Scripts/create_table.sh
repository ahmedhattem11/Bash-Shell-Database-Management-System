#! /bin/bash
shopt -s extglob

clear
while true
do
    read -p "Enter table name: " table
        case $table in 
            # case if name is of charachters and numbers
            +([a-zA-Z]))

            # check that it's unique
                if [ ! -e $table ]; then
                    touch "${table}-meta"
                    clear
                    echo -e "Please, enter number of columns in your new table."
                    echo "**Note that the first column is your Primary Key**"
                    sleep 3
                    clear
                    read -p "Number of columns in $table table: " columns
                    clear
                    i=1
                    while [ "$i" -le "$columns" ]
                    do
                        read -p "Name of Column number $i: " columnName
                        echo -n "$columnName:" >> "${table}-meta"
                        echo "Column ($i) is set to ($columnName)"
                        echo "Data type of column ($columnName): "
                        PS3="Enter 1 or 2 for your data type: "
                        select dataType in int string
                        do
                            
                            echo "Data type of column ($columnName) is set to ($dataType)"
                            sleep 3
                            clear
                            echo -e -n "$dataType\n" >> "${table}-meta"
                            break
                        done
                        ((i++))
                    done 
                    touch $table
                    clear
                    echo -e "Table created successfully!\n"
                    sleep 2
                    . ../../Scripts/DatabaseMenu.sh
                    
                        
                    else
                        echo "This name already exists!"
                    fi
              
                ;;
            *" "*)
                echo "Database name does not accept spaces"
                ;;
            *)
                echo Database name accepts alphabets only
        esac         
done        