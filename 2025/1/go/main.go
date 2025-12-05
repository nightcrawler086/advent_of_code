package main

import (
	"bufio"
	"os"
	"log"
	"fmt"
	"strconv"
)

const input = "../input.txt"

var current, new, zeroes int64 = 50, 0, 0

func move_remainder(c int64, d string, m int64) int64 {
	var new_position int64
	switch d {
		case "L":
			new_position = c - m
		case "R":
			new_position = c + m
		default:
			panic("Invalid Direction")
	}

	if new_position == 0 || new_position == 100 {
		new_position = 0
		zeroes++
	} else if new_position < 0 {
		new_position = new_position + 100
		if c != 0 {
			zeroes++
		}
	} else if new_position > 100 {
		new_position = new_position - 100
		if c != 0 {
			zeroes++
		}
	}
	return new_position
}

func main() {
	// read file line by line for moves
	// var to update count
	// how to track position?
	file, err := os.Open(input)
	if err != nil {
		log.Fatalf("Error opening file %v", err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		line := scanner.Text()
		direction := line[0:1]
		clicks, err := strconv.ParseInt(line[1:], 10, 0)
		if err != nil {
			fmt.Println("Error converting string to int:", err)
		}
		// Increment once per 100 moves
		zeroes = zeroes + (clicks / 100)
		remaining_clicks := clicks % 100
		current = move_remainder(current, direction, remaining_clicks)
		fmt.Printf("Move: %v | Current: %v | Remaining Clicks: %v | Zeroes: %v\n", line, current, remaining_clicks, zeroes)
	}

	if err := scanner.Err(); err != nil {
		log.Fatalf("Error readinf from file: %v", err)
	}

	fmt.Printf("Zeroes: %d", zeroes)
}
