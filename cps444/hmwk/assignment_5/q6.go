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
	month := 5
	day := 21
	season := ""
	switch month {
	case 1, 2, 3:
		season = "Winter"
	case 4, 5, 6:
		season = "Spring"
	case 7, 8, 9:
		season = "Summer"
	case 10, 11, 12:
		season = "Autumn"
	}
	if (month % 3 == 0) && (day >= 21) {
		switch season {
		case "Winter":
			season = "Spring"
			break
		case "Spring":
			season = "Summer"
			break
		case "Summer":
			season = "Autumn"
			break
		case "Autumn":
			season = "Winter"
			break
		}
	}
	fmt.Printf("season is %s\n", season)
	return
}
