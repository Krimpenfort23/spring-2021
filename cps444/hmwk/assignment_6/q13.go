//
// Question 13
// Homework 6
// Author: Evan Krimpenfort
//
package main

import(
	"fmt"
	"math"
)

func Sum(set []float64) float64 {
	sum := 0.0
	for _, value := range set {
		sum += value
	}
	return sum
}

func Sum2(set []float64, mean float64) float64 {
	sum := 0.0
	for _, value := range set {
		sum += math.Pow(value - mean, 2.0)
	}
	return sum
}

func main() {
	n := 5
	var set = []float64{2.3, 4.5, 6.1, 1.9, 7.2}
	xi := Sum(set)
	x_ := xi / float64(n)
	s := math.Sqrt(Sum2(set, x_)/float64(n))
	fmt.Printf("for a set of %d values, the average is %.2f and the standard deviation is %.2f\n", n, x_, s)
	return
}
