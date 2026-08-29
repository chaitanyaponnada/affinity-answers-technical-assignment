#!/bin/bash

# this is to Check if exactly one URL argument was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 \"CSV_URL\""
    exit 1
fi

csv_url="$1"

# now Download the CSV data
csv_data=$(curl -fsSL "$csv_url")

# Check if the download was successful
if [ $? -ne 0 ] || [ -z "$csv_data" ]; then
    echo "Error: Failed to retrieve the CSV data."
    exit 1
fi

# Print the table header
printf "%-10s %-40s %-40s\n" "Founded" "Company" "Location"
printf '%s\n' "------------------------------------------------------------------------------------------"

# Process the CSV data
printf "%s\n" "$csv_data" |
awk '
BEGIN {
    FPAT = "([^,]*)|(\"[^\"]+\")"
}

# Skip the CSV header
NR == 1 {
    next
}

{
    company = $2
    location = $5
    founded = $8

    # Remove surrounding double quotes
    gsub(/^"|"$/, "", company)
    gsub(/^"|"$/, "", location)
    gsub(/^"|"$/, "", founded)

    # Extract the first four-digit founding year
    if (match(founded, /[0-9]{4}/)) {
        year = substr(founded, RSTART, RLENGTH)
    } else {
        next
    }

    # Use TAB as the temporary separator
    printf "%s\t%s\t%s\n", year, company, location
}
' |
sort -n -k1,1 |
awk -F '\t' '
{
    printf "%-10s %-40s %-40s\n", $1, $2, $3
}
'