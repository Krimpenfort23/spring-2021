//
// Question 10
// Homework 6
// Author: Evan Krimpenfort
//
package main

import(
	"fmt"
)

func main() {
	tally := make(map[rune]int)
	word := ""
	fmt.Printf("Enter in a string to get the most frequent letter: ")
	fmt.Scanf("%s", &word)
	letters := []rune(word)
	for i:=0; i<len(word); i++ {
		tally[letters[i]] += 1
	}
	largest := 0
	for _, i := range tally {
		if (i > largest) { largest = i }
	}
	for letter, i := range tally {
		if (i == largest) {
			fmt.Printf("%c", letter)
		}
	}
	fmt.Println()
	return
}
