//
// Question 3
// Homework 6
// Author: Evan Krimpenfort
//
package main

import(
	"fmt"
)

func main() {
	hour1 := 17
	minute1 := 30
	hour2 := 9
	minute2 := 00
	if hour1 > hour2 {
		fmt.Printf("time 1 is %d hours and %d minutes\ntime 2 is %d hours and %d minutes\n", hour1, minute1, hour2, minute2)
	} else if hour1 == hour2 {
		if minute1 > minute2 {
			fmt.Printf("time 1 is %d hours and %d minutes\ntime 2 is %d hours and %d minutes\n", hour1, minute1, hour2, minute2)
		} else if minute1 == minute2 {
			fmt.Printf("times are the same...\ntime 1 is %d hours and %d minutes\ntime 2 is %d hours and %d minutes\n", hour1, minute1, hour2, minute2)
		} else {
			fmt.Printf("time 1 is %d hours and %d minutes\ntime 2 is %d hours and %d minutes\n", hour2, minute2, hour1, minute1)
		}
	} else {
		fmt.Printf("time 1 is %d hours and %d minutes\ntime 2 is %d hours and %d minutes\n", hour2, minute2, hour1, minute1)
	}
	return
}
