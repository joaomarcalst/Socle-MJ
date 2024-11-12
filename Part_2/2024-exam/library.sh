#!/bin/bash

# Since i am a MacOS user, i had to reorganize somes steps of the script to manage to execute some lines.
# in this case, i added code versions to Linux and MacOS.

# Databases Paths
BOOKS_FILE="books.csv"
MEMBERS_FILE="members.csv"
LENDING_FILE="lending.csv"

# Function to quit or exit the script
quit() {
    echo -e "\nExiting the library script.\n"
    exit 0
}

# 1. Function to list all entries in the specified database
# Lists books or members in sorted order based on ISBN for books and name for members.
list_entries() {
    local entity="$1"
    case $entity in
        books)
            echo "Listing all books:"
            awk -F',' '{printf "%-20s %-30s %-12s %-6s\n", $1, $2, $3, $4}' "$BOOKS_FILE" | sort -k1,1
            ;;
        members)
            echo "Listing all members:"
            awk -F',' '{printf "%-10s %-20s %-12s %-6s\n", $1, $2, $3, $4}' "$MEMBERS_FILE" | sort -k2,2
            ;;
        *)
            echo "Invalid list type. Use 'books' or 'members'."
            ;;
    esac
}

# 2. Function to search for entries by key in the databases
# Searches for entries with a title or name starting with a given key.
search_entries() {
    local entity="$1"
    local search_key="$2"

    # If no key is provided, list all entries
    if [[ -z "$search_key" ]]; then
        list_entries "$entity"
        return
    fi

    case $entity in
        books)
            echo "Searching for books with titles starting with '$search_key':"
            results=$(awk -F',' -v key="$search_key" 'NR > 1 && tolower($2) ~ "^"tolower(key) {print $1, "-", $2}' "$BOOKS_FILE" | sort -k1,1)
            ;;
        members)
            echo "Searching for members with names starting with '$search_key':"
            results=$(awk -F',' -v key="$search_key" 'NR > 1 && tolower($2) ~ "^"tolower(key) {print $1, "-", $2}' "$MEMBERS_FILE" | sort -k2,2)
            ;;
        *)
            echo "Invalid search type. Use 'books' or 'members'."
            return
            ;;
    esac

    if [[ -z "$results" ]]; then
        echo "No entry found for '$search_key' in $entity."
    else
        echo "$results"
    fi
}

# 3. Function to delete an entry if conditions are met
# Marks a book or member as deleted if no active loans are present.
delete_entry() {
    local entity="$1"
    local identifier="$2"

    case $entity in
        book)
            if grep -q "^$identifier," "$BOOKS_FILE"; then
                if grep -q "^$identifier,[^,]*,[^,]*,1" "$BOOKS_FILE"; then
                    echo "Error: Book with ISBN $identifier is already marked as deleted."
                    return
                fi
                if grep -q "^$identifier,[^,]*,[^,]*,[^,]*,0" "$LENDING_FILE"; then
                    echo "Error: Book with ISBN $identifier cannot be deleted as it has active loans."
                    return
                fi
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    sed -i "" "/^$identifier,/ s/,[^,]*$/,1/" "$BOOKS_FILE"  # macOS version
                else
                    sed -i "/^$identifier,/ s/,[^,]*$/,1/" "$BOOKS_FILE"     # Linux version
                fi
                echo "Book with ISBN $identifier marked as deleted."
            else
                echo "Error: Book with ISBN $identifier not found."
            fi
            ;;
        member)
            if grep -q "^$identifier," "$MEMBERS_FILE"; then
                if grep -q "^$identifier,[^,]*,[^,]*,1" "$MEMBERS_FILE"; then
                    echo "Error: Member with ID $identifier is already marked as deleted."
                    return
                fi
                if grep -q "^[^,]*,$identifier,[^,]*,[^,]*,0" "$LENDING_FILE"; then
                    echo "Error: Member with ID $identifier cannot be deleted as they have active loans."
                    return
                fi
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    sed -i "" "/^$identifier,/ s/,[^,]*$/,1/" "$MEMBERS_FILE"  # macOS version
                else
                    sed -i "/^$identifier,/ s/,[^,]*$/,1/" "$MEMBERS_FILE"     # Linux version
                fi
                echo "Member with ID $identifier marked as deleted."
            else
                echo "Error: Member with ID $identifier not found."
            fi
            ;;
        *)
            echo "Invalid delete type. Use 'book' or 'member'."
            ;;
    esac
}

# 4. Function to validate ISBN format (XXX-X-XXXXX-XXX-X)
validate_isbn() {
    local isbn="$1"
    if [[ "$isbn" =~ ^[0-9]{3}-[0-9]-[0-9]{5}-[0-9]{3}-[0-9]$ ]]; then
        return 0
    else
        return 1
    fi
}

# 5. Function to update or add a book entry
# Adds or updates a book entry with title and ISBN in the database.
update_book() {
    local isbn="$1"
    local title="$2"

    if ! validate_isbn "$isbn"; then
        echo "Error: Invalid ISBN format."
        return
    fi

    if grep -q "^$isbn," "$BOOKS_FILE"; then
        sed -i "/^$isbn,/ s/^[^,]*,[^,]*/$isbn,$title/" "$BOOKS_FILE"
        echo "Book with ISBN $isbn updated with title '$title'."
    else
        echo "$isbn,$title,,0" >> "$BOOKS_FILE"
        echo "New book with ISBN $isbn and title '$title' added."
    fi
}

# 6. Function to update or add a member entry
# Adds or updates a member entry with ID and name in the database.
update_member() {
    local member_id="$1"
    local name="$2"

    if grep -q "^$member_id," "$MEMBERS_FILE"; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i "" "/^$member_id,/ s/^[^,]*,[^,]*/$member_id,$name/" "$MEMBERS_FILE"  # macOS version
        else
            sed -i "/^$member_id,/ s/^[^,]*,[^,]*/$member_id,$name/" "$MEMBERS_FILE"     # Linux version
        fi
        echo "Member with ID $member_id updated with name '$name'."
    else
        echo "$member_id,$name,0,0" >> "$MEMBERS_FILE"
        echo "New member with ID $member_id and name '$name' added."
    fi
}

# 7. Function to suspend a member
# Marks a member as suspended in the database.
suspend_member() {
    local member_id="$1"

    if grep -q "^$member_id," "$MEMBERS_FILE"; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i "" "/^$member_id,/ s/\([0-9]\),0$/\1,1/" "$MEMBERS_FILE"  # macOS version
        else
            sed -i "/^$member_id,/ s/\([0-9]\),0$/\1,1/" "$MEMBERS_FILE"     # Linux version
        fi
        echo "Member with ID $member_id has been suspended."
    else
        echo "Error: Member with ID $member_id not found."
    fi
}

# 8. Function to resume a suspended member
# Removes the suspended status from a member in the database.
resume_member() {
    local member_id="$1"

    if grep -q "^$member_id," "$MEMBERS_FILE"; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i "" "/^$member_id,/ s/\([0-9]\),1$/\1,0/" "$MEMBERS_FILE"  # macOS version
        else
            sed -i "/^$member_id,/ s/\([0-9]\),1$/\1,0/" "$MEMBERS_FILE"     # Linux version
        fi
        echo "Member with ID $member_id has been resumed."
    else
        echo "Error: Member with ID $member_id not found."
    fi
}

# 9. Function to loan a book to a member
# Records a book loan for a member if the member and book meet conditions.
loan_book() {
    local isbn="$1"
    local member_id="$2"
    
    # Get current date and calculate end date (7 days later) using macOS-compatible date command
    local start_date=$(date +%Y-%m-%d)
    local end_date=$(date -v+7d +%Y-%m-%d)

    # Check if the book exists and is not deleted
    if ! grep -q "^$isbn,.*,,0" "$BOOKS_FILE"; then
        echo "Error: Book with ISBN $isbn is either deleted or does not exist."
        return
    fi

    # Check if the book is reserved by a different member
    local reserved_by=$(awk -F',' -v isbn="$isbn" '$1 == isbn {print $3}' "$BOOKS_FILE")
    if [[ -n "$reserved_by" && "$reserved_by" != "$member_id" ]]; then
        echo "Error: Book with ISBN $isbn is reserved by a different member."
        return
    fi

    # Check if the book is already loaned and not returned
    if grep -q "^$isbn,.*,.*,.*,0" "$LENDING_FILE"; then
        echo "Error: Book with ISBN $isbn is already loaned."
        return
    fi

    # Check if the member exists, is not deleted, and is not suspended
    if ! awk -F',' -v id="$member_id" '$1 == id && $3 == "0" && $4 == "0"' "$MEMBERS_FILE" > /dev/null; then
        echo "Error: Member with ID $member_id is either deleted or suspended."
        return
    fi

    # Loan is permitted, so add an entry to the lending database
    echo "$isbn,$member_id,$start_date,$end_date,0" >> "$LENDING_FILE"
    echo "Book with ISBN $isbn has been loaned to member with ID $member_id from $start_date to $end_date."

    # If the book was reserved by the member, clear the reservation in the books database
    if [[ "$reserved_by" == "$member_id" ]]; then
        sed -i "" "/^$isbn,/ s/,$member_id,/,/" "$BOOKS_FILE"
        echo "Reservation for book with ISBN $isbn by member $member_id has been cleared."
    fi
}

# 10. Function to return a loaned book
# Marks a loaned book as returned if an active loan is found.
return_book() {
    local isbn="$1"
    local loan_found=false
    local returned=false

    # Check if there's an active loan for the book (returned status = 0)
    if grep -q "^$isbn,.*,.*,.*,0$" "$LENDING_FILE"; then
        loan_found=true
        # Mark the loan as returned
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i "" "/^$isbn,.*,.*,.*,0$/ s/,0$/,1/" "$LENDING_FILE"  # macOS
        else
            sed -i "/^$isbn,.*,.*,.*,0$/ s/,0$/,1/" "$LENDING_FILE"     # Linux
        fi
        echo "Book with ISBN $isbn has been successfully returned."
    fi

    # Check if the book loan was already returned
    if grep -q "^$isbn,.*,.*,.*,1$" "$LENDING_FILE"; then
        returned=true
    fi

    # Display error messages for conditions where no active loan was found
    if [[ "$loan_found" = false && "$returned" = true ]]; then
        echo "Error: The book with ISBN $isbn has already been returned."
    elif [[ "$loan_found" = false && "$returned" = false ]]; then
        echo "Error: No loan entry found for book with ISBN $isbn."
    fi
}

# 11. Function to reserve a book
# Reserves a book for a member if available and not already reserved by another.
reserve_book() {
    local isbn="$1"
    local member_id="$2"

    # Check if the book exists and is not already reserved
    if ! grep -q "^$isbn," "$BOOKS_FILE"; then
        echo "Error: Book with ISBN $isbn does not exist."
        return
    fi

    # Check if the book is already reserved by another member
    local reserved_by=$(awk -F',' -v isbn="$isbn" '$1 == isbn {print $3}' "$BOOKS_FILE")
    if [[ -n "$reserved_by" && "$reserved_by" != "$member_id" ]]; then
        echo "Error: Book with ISBN $isbn is already reserved by another member."
        return
    fi

    # Check if the member exists
    if ! grep -q "^$member_id," "$MEMBERS_FILE"; then
        echo "Error: Member with ID $member_id does not exist."
        return
    fi

    # Reserve the book by updating the reserved_by field in books.csv
    if [[ -z "$reserved_by" ]]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i "" "/^$isbn,/ s/,,/,${member_id},/" "$BOOKS_FILE"  # macOS version
        else
            sed -i "/^$isbn,/ s/,,/,${member_id},/" "$BOOKS_FILE"     # Linux version
        fi
        echo "Book with ISBN $isbn has been reserved by member with ID $member_id."
    else
        echo "Error: Book with ISBN $isbn is already reserved."
    fi
}

# 12. Function to display overdue loans
# Shows overdue loans that exceed a specified number of days late.
report() {
    local overdue_days="$1"
    local current_date=$(date +%Y-%m-%d)

    echo -e "ISBN\tMember Name\tStart Date\tEnd Date\tDays Late"
    
    while IFS=',' read -r isbn member_id start_date end_date returned; do
        # Only consider loans that haven't been returned
        if [[ "$returned" == "0" ]]; then
            # Calculate the number of days late
            if [[ "$OSTYPE" == "darwin"* ]]; then
                days_late=$(( ( $(date -jf "%Y-%m-%d" "$current_date" +%s) - $(date -jf "%Y-%m-%d" "$end_date" +%s) ) / 86400 ))
            else
                days_late=$(( ( $(date -d "$current_date" +%s) - $(date -d "$end_date" +%s) ) / 86400 ))
            fi

            # Check if loan is overdue
            if [[ $days_late -gt 0 && ( -z "$overdue_days" || $days_late -ge $overdue_days ) ]]; then
                # Find the member's name from members.csv
                member_name=$(awk -F',' -v id="$member_id" '$1 == id {print $2}' "$MEMBERS_FILE")
                
                # Display overdue loan information
                echo -e "$isbn\t$member_name\t$start_date\t$end_date\t$days_late"
            fi
        fi
    done < "$LENDING_FILE"
}

# Main loop to read commands
# This loop waits for user input and calls the appropriate function based on the command entered.
while true; do
    echo -e "\nEnter command (quit, list [books|members], search [books|members] <key>, delete [book|member] <key>, update book <isbn> <title>, update member <id> <name>, suspend <member_id>, resume <member_id>, loan <isbn> <member_id>, return <isbn>, reserve <isbn> <member_id>, report [days]):\n"
    read -r command entity key value

    case $command in
        quit|exit)
            quit
            ;;
        list)
            list_entries "$entity"
            ;;
        search)
            search_entries "$entity" "$key"
            ;;
        delete)
            delete_entry "$entity" "$key"
            ;;
        update)
            case $entity in
                book)
                    update_book "$key" "$value"
                    ;;
                member)
                    update_member "$key" "$value"
                    ;;
                *)
                    echo "Invalid update type. Use 'book' or 'member'."
                    ;;
            esac
            ;;
        suspend)
            suspend_member "$entity"
            ;;
        resume)
            resume_member "$entity"
            ;;
        loan)
            loan_book "$entity" "$key"
            ;;
        return)
            return_book "$entity"
            ;;
        reserve)
            reserve_book "$entity" "$key"
            ;;
        report)
            report "$entity"
            ;;
        *)
            echo "Invalid command."
            ;;
    esac
done