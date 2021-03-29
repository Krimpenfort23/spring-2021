//
// Question 11
// Homework 6
// Author: Evan Krimpenfort
//
package main

import(
	"fmt"
)

func main() {
	n := 0
	fmt.Printf("Enter the square number for the multiplication table: ")
	fmt.Scanf("%d", &n)
	for i:=1; i<=n; i++ {
		for j:=1; j<=n; j++ {
			fmt.Printf("%d\t",i*j)
		}
		fmt.Println()
	}
	return
}
