//
// Question 4
// Homework 6
// Author: Evan Krimpenfort
//
package main

import(
	"fmt"
)

func main() {
	grade := ""
	points := 0.0
	fmt.Printf("Enter a letter grade: ")
	fmt.Scanf("%s", &grade)
	switch grade {
	case "A+", "A":
		points = 4.0
	case "A-":
		points = 3.7
	case "B+":
		points = 3.3
	case "B":
		points = 3.0
	case "B-":
		points = 2.7
	case "C+":
		points = 2.3
	case "C":
		points = 2.0
	case "C-":
		points = 1.7
	case "D+":
		points = 1.3
	case "D":
		points = 1.0
	case "D-":
		points = 0.7
	case "F":
		points = 0.0
	default:
		fmt.Println("Not a letter grade.")
		return
	}
	fmt.Printf("A letter grade of %s is %.1f points.\n", grade, points)
	return
}
