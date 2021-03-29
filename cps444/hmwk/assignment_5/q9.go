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
	total := 0.0;
	total_credits := 0.0
	GPA_avg := 0.0
	var grades = [5][2]float64{{4.0, 3.0}, {3.0, 3.0}, {3.0, 3.0}, {4.0, 4.0}, {2.7, 4.0}}
	for i:=1; i<5; i++ {
		total += grades[i][0] * grades[i][1]
		total_credits += grades[i][1]
	}
	GPA_avg = total/total_credits
	fmt.Printf("Average GPA is %.2f\n", GPA_avg)
	return
}
