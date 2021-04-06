// 
// Question 5
// Homework 7
// Author: Evan Krimpenfort
//

package main

import (
	"fmt"
	"os"
)

func main() {
	const total_judges = 7
	judges := make([]float64, total_judges)
	dod := 0.0
	const multiplier = 0.6

	for i:=0; i<total_judges; i++ {
		fmt.Printf("Enter a score for Judge %d: ", i+1)
		fmt.Scanln(&judges[i])

		// input checking stop 1
		if (judges[i] < 0 || judges[i] > 10) {
			fmt.Println("Invalid Input: A Judge's score should be a 64-bit floating point number between 0 and 10.")
			os.Exit(1)
		}
	}

	fmt.Printf("Enter the degree of difficulty the diver took: [Must be between 1.2 and 3.8] ")
	fmt.Scanln(&dod)

	// input checking stop 2
	if (dod < 1.2 || dod > 3.8) {
		fmt.Println("Invalid Input: A Degree of Difficulty score should be a 64-bit floating point number between 1.2 and 3.8.")
		os.Exit(1)
	}

	// find smallest
	smallest := 10.0
	smallest_index := 0
	for i, score := range judges {
		if (smallest >= score) {
			smallest = score
			smallest_index = i
		}
	}
	judges[smallest_index] = 0.0

	// find largest
	largest := 0.0
	largest_index := 0
	for i, score := range judges {
		if (largest < score) {
			largest = score
			largest_index = i
		}
	}
	judges[largest_index] = 0.0

	// sum
	sum := 0.0
	for _, score := range judges {
		sum += score
	}

	// sum x dod x multiplier
	sum = sum*dod*multiplier
	fmt.Printf("The divers score was %.2f\n", sum)
}
