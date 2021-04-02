//
// Question 1
// Homework 5
// Author: Evan Krimpenfort
//
package main

import (
	"fmt"
)

func main() {
	monthNumber := 0
	fmt.Printf("Enter the number of a month (1-12): ")
	fmt.Scan(&monthNumber)
	switch monthNumber {
	case 1:
		fmt.Println("January")
	case 2:
		fmt.Println("Feburary")
	case 3:
		fmt.Println("March")
	case 4:
		fmt.Println("April")
	case 5:
		fmt.Println("May")
	case 6:
		fmt.Println("June")
	case 7:
		fmt.Println("July")
	case 8:
		fmt.Println("August")
	case 9:
		fmt.Println("September")
	case 10:
		fmt.Println("October")
	case 11:
		fmt.Println("November")
	case 12:
		fmt.Println("December")
	default:
		fmt.Println("Number is not a valid month...")
	}
	return
}
