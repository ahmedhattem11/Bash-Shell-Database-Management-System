# H.N.D.B.M.S (Hatem & Nawasany Database Management System)

## Overview

H.N.D.B.M.S is a simple database management system designed to work on a Unix/Linux environment, specifically for managing databases and tables within a home network. It offers the following functionalities:

- Create Database: Create a new database with a unique name.
- Connect Database: Connect to an existing database.
- Drop Database: Drop an existing database.
- List Database: List all available databases.
- Create Table: Create a new table within a database.
- Select Table: Select and display the contents of a table.
- Drop Table: Drop an existing table within a database.
- Update Data: Update existing data in a table.
- Insert Data: Insert new data into a table.
- Delete Data: Delete existing data from a table.

## Prerequisites

- Unix/Linux operating system
- Bash shell (version 4 or higher recommended)

## Installation

1. Clone the repository: `git clone ahmedhattem11/H.N.D.B.M.S`
2. Create the HNDBMS directory: `mkdir HNDBMS`
3. Make the shell scripts executable: `chmod +x main.sh Scripts/*.sh`

## Usage

1. Run `main.sh` to start the H.N.D.B.M.S shell.
2. Follow the on-screen menu to perform actions such as creating, connecting to, or dropping a database, listing databases, or exiting the system.
3. When creating a database, you will be prompted to enter a unique name for the database.
4. When connecting to a database, select an existing database from the list.
5. When dropping a database, select a database from the list.
6. Tables can be created, selected, dropped, updated, inserted into, and deleted from within the selected database.

## Scripts

- `main.sh`: The main script that provides a menu-driven interface for accessing database functionalities.
- `create_db.sh`: Script to create a new database.
- `connect_db.sh`: Script to connect to an existing database.
- `drop_db.sh`: Script to drop an existing database.
- `list_db.sh`: Script to list all available databases.
- `create_table.sh`: Script to create a new table within a database.
- `select_table.sh`: Script to select and display the contents of a table.
- `drop_table.sh`: Script to drop an existing table within a database.
- `update_data.sh`: Script to update existing data in a table.
- `insert_data.sh`: Script to insert new data into a table.
- `delete_data.sh`: Script to delete existing data from a table.
- `DatabaseMenu.sh`: Provides a menu-driven interface for performing table-related operations within a selected database.

## Contributing

Contributions are welcome! If you have any suggestions, enhancements, or bug fixes, feel free to submit a pull request.

## Authors

- Ahmed Hatem
- Mahmoud Hatem
- Ibrahim El- Nawasany
