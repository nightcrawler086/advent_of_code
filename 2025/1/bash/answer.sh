#!/bin/bash

input_file=../input.txt
#input_file=../input_test.txt

current_pos=50
zeros=0

count_crosses() {
	local CLICKS=$1
	local CROSSES=$((clicks / 100))
	((ZEROES += CROSSES))
}

move() {
	local CURRENT=$1
	local DIRECTION=$2
	local CLICKS=$3
}

for i in `cat $input_file`; do 
	direction=${i:0:1}
	clicks=${i:1:3}
	crosses=$((clicks / 100))
	if [[ "$crosses" -gt 0 ]]; then
		"Passed zero $crosses times"
		((zeros += crosses))
	fi
	moves=$((clicks % 100))
	case "$direction" in 
		"L")
			new_pos=$((current_pos - moves))
			;;
		"R")
			new_pos=$((current_pos + moves))
			;;
		*)
			echo "You shouldnt be here"
			exit 1
			;;
	esac
	if [[ $new_pos -eq 0 || $new_pos -eq 100 ]]; then
		new_pos=0
		((zeros++))
	elif [[ $new_pos -lt 0 ]]; then
		new_pos=$((new_pos + 100))
		if [[ $current_pos -ne 0 ]]; then
			((zeros++))
		fi
	elif [[ $new_pos -gt 100 ]]; then
		new_pos=$((new_pos - 100))
		if [[ $current_pos -ne 0 ]]; then
			((zeros++))
		fi
	fi
	echo "[$i] Previous: $current_pos | New position: $new_pos | Zeros: $zeros"
	echo "-----------------------------------------------"
	current_pos=$new_pos
done

echo "Code is: $zeros"
