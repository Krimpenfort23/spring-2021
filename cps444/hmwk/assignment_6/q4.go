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
	T := 0.0
	RH := 0.0
	fmt.Printf("Enter in an RH between 0 and 1 and a T: ")
	fmt.Scanf("%f %f", &RH, &T)
	f := (a*T)/(b+T) + math.Log(RH)
	Td := (b*f)/(a-f)
	fmt.Printf("Dew point is %.2f\n", Td)
	return
}
