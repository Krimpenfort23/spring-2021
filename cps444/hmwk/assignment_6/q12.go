//
// Question 4
// Homework 6
// Author: Evan Krimpenfort
//
package main

import(
	"fmt"
	"math"
)

func IsPrime(num int) int {
	for i:=2; i <= int(math.Floor(float64(num)/2)); i++ {
		if num%i == 0 {
			return 0
		}
	}
	return 1
}

func main() {
	n := 0
	fmt.Printf("Enter the max prime number: ")
	fmt.Scanf("%d", &n)
	for i:=2; i<n; i++ {
		if (IsPrime(i) == 1) {
			fmt.Println(i)
		}
	}
	return
}
