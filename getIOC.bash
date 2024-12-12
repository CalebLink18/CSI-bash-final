#!/bin/bash

# a function to get the indicators of compromise from a web page
function getIOC() {

webpage=$(curl -s 10.0.17.6/IOC.html)

table=$(echo "$webpage" | sed -n '/<table>/,/<\/table>/p')

rows=$(echo "$table" | grep -oP '(?s)<tr.*?>.*?</tr?')

outputFile="IOC.txt"
> "$outputFile"

#loop through each row to extract a bit of the first column into an array
while IFS= read -r row; do
	firstTD=$(echo "$row" | grep -oP '(?s)<td.*?>.*?</td>' | head -1)
	cleanerData=$(echo "$firstTD" | sed 's/<[^>]*>//g')
	echo "$cleanerData" >> "$outputFile"
done <<< "$rows"
}
