#!/bin/bash

function filter_apache_logs() {

local log_file="$1"
local ioc_file="$2"

#check if inputs exist
if [[ ! -f "$log_file" ]]; then
	echo "Apache log file error."
	return 1
fi
if [[ ! -f "$iov_file" ]]; then
	echo "IOC.txt error"
	return 1
fi

#filters log entries what is inside of IOC.txt
while IFS= read -r ioc; do
	if [[ -n "$ioc" ]]; then
		grep -F "$ioc" "$log_file" >> report.txt
	fi
done < "$ioc_file"
}
