// 
// Question 2
// Homework 7
// Author: Evan Krimpenfort
//

package main

import (
	"fmt"
	"math/rand"
	"math"
	"time"
	"strconv"
)

func main() {
	// QUESTION 1 PREVIOUSLY //
	// set the seed
	rand.Seed(int64(time.Now().Second()))

	flag := 0
	previous_roll := 0
	roll := 0
	run := "  "
	run_slice := []rune(run)

	// first roll
	roll = int(math.Floor((rand.Float64() * 6) + 1))
	run = run + strconv.Itoa(roll) + "  "
	for i:=1; i<20; i++ {
		previous_roll = roll
		roll = int(math.Floor((rand.Float64() * 6) + 1))

		// check for if previous_roll and roll are the same
		if (previous_roll == roll) {
			// is the row continuing?
			if (flag == 1) {
				run = run + strconv.Itoa(roll) + "  "
			// new row starting
			} else {
				run = run + strconv.Itoa(roll) + "  "
				run_slice = []rune(run)
				run_slice[len(run_slice)-7] = '('
				run = string(run_slice)
				flag = 1
			}
		} else {
			// check to see if the row ends
			if (flag == 1) {
				flag = 0
				run_slice = []rune(run)
				run_slice[len(run_slice)-2] = ')'
				run = string(run_slice)
				run = run + strconv.Itoa(roll) + "  "
			// no row -- regular
			} else {
				run = run + strconv.Itoa(roll) + "  "
			}
		}
	}

	// check for an ending pair
	if (flag == 1) {
		flag = 0
		run_slice = []rune(run)
		run_slice[len(run_slice)-2] = ')'
		run = string(run_slice)
	}

	// QUESTION 2 //
	run_slice = []rune(run)
	index1 := 0
	final_index1 := 0
	index2 := 0
	final_index2 := 0
	space := 0
	longest := 0

	// find the longest
	for i:=0; i < len(run); i++ {
		if (run_slice[i] == '(') {
			index1 = i
		} else if (run_slice[i] == ')') {
			index2 = i
			space = index2 - index1
			if (space > longest) {
				longest = space
				final_index1 = index1
				final_index2 = index2
			}
		}
	}

	// single out the longest
	for i:=0; i < len(run); i++ {
		if (run_slice[i] == '(' && final_index1 != i) {
			run_slice[i] = ' '
		} else if (run_slice[i] == ')' && final_index2 != i) {
			run_slice[i] = ' '
		}
	}

	run = string(run_slice)
	fmt.Println(run)
}
