// 
// Question 3
// Homework 7
// Author: Evan Krimpenfort
//

package main

import (
	"fmt"
)

func main() {
	n := 0
	fmt.Printf("To what number n would you like to see prime numbers: ")
	fmt.Scanf("%d", &n)

	// create the set
	// all start out as 1
	var set = make([]int, n+1)
	for i:=0; i<=n; i++ {
		set[i] = 1
	}

	// sieve through sqrt(n) (or i*i == n)
	for i:=2; i*i<n; i++ {
		if (set[i] == 1) {
			// goes through the multiples and sets them to 0
			// first multiple = i*i
			// next multiple is i
			for j:=i*i; j<n; j += i {
				set[j] = 0
			}
		}
	}

	// print anything in the set that is a 1 (Prime)
	for i:=2; i<n; i++ {
		if (set[i] == 1) {
			fmt.Printf("%d\t", i)
		}
	}
	fmt.Println()
}
