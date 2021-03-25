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

func main() {
	a := 17.27
	b := 237.7
	T := 25.0
	RH := 0.5
	f := (a * T)/(b + T) + math.Log(RH)
	Td := (b * f)/(a - f)
	fmt.Printf("Td is %.2f\n", Td)
	return
}
