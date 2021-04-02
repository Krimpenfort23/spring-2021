//
// Question 2
// Homework 6
// Author: Evan Krimpenfort
//
package main

import(
	"fmt"
	"math"
)

func main() {
	first := 0.0
	second := 0.0
	diff := 0.0
	seconds := 0.0
	fmt.Printf("Please enter the first time: ")
	fmt.Scan(&first)
	fmt.Printf("Please enter the second time: ")
	fmt.Scan(&second)
	if (second > first) {
		diff = second - first
	} else {
		diff = (2360 - first) + second
	}
	seconds = diff - (math.Floor(diff/100)*100)
	fmt.Printf("%.0f hours %.0f minutes\n", math.Floor(diff/100), seconds)
	return
}
