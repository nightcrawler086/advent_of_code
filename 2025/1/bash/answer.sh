#!/bin/bash

input_file=../input.txt
#input_file=../input_test.txt

CURRENT_POSITION=50
NEW_POSITION=0
ZEROES=0

move_remainder() {
	local CURRENT=$1
	local DIRECTION=$2
	local CLICKS=$3
	case "$DIRECTION" in 
		"L") NEW_POSITION=$((CURRENT - CLICKS)) ;;
		"R") NEW_POSITION=$((CURRENT + CLICKS)) ;;
		*) return 1 ;;
	esac
	if [[ $NEW_POSITION -eq 0 || $NEW_POSITION -eq 100 ]]; then
		NEW_POSITION=0
		((ZEROES++))
	elif [[ $NEW_POSITION -lt 0 ]]; then
		NEW_POSITION=$((NEW_POSITION + 100))
		if [[ $CURRENT_POSITION -ne 0 ]]; then
			((ZEROES++))
		fi
	elif [[ $NEW_POSITION -gt 100 ]]; then
		NEW_POSITION=$((NEW_POSITION - 100))
		if [[ $CURRENT_POSITION -ne 0 ]]; then
			((ZEROES++))
		fi
	fi
}

# for i in `cat $input_file`; do 
while IFS=\n read -r i; do
	direction=${i:0:1}
	clicks=${i:1:3}
	((ZEROES += clicks / 100 ))
	move_remainder $CURRENT_POSITION $direction $((clicks % 100))
	echo "[$i] Previous: $CURRENT_POSITION | New: $NEW_POSITION | Zeros: $ZEROES"
	echo "------------------------------------------"
	CURRENT_POSITION=$NEW_POSITION
done < "$input_file"

echo "Code is: $ZEROES"
