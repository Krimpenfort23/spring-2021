//
// Question 3
// Homework 6
// Author: Evan Krimpenfort
//
package main

import(
	"fmt"
)

func main() {
	phone := "4155551212"
	phoneAsRunes := []rune(phone)
	formatted := "(" + string(phoneAsRunes[0:3]) + ") " + string(phoneAsRunes[3:6]) + "-" + string(phoneAsRunes[6:10])
	fmt.Printf("%s\n", formatted)
	return
}
