//
// Question 7
// Homework 6
// Author: Evan Krimpenfort
//
package main

import(
	"fmt"
)

func main() {
	month := 0
	year := 0
	days := 0
	fmt.Printf("Enter a month and year to get the days in the month: [x xxxx] ")
	fmt.Scanf("%d %d", &month, &year)

	switch month {
	case 1:
		days = 31
	case 2:
		if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
			days = 29
		} else {
			days = 28
		}
	case 3:
		days = 31
	case 4:
		days = 30
	case 5:
		days = 31
	case 6:
		days = 30
	case 7:
		days = 31
	case 8:
		days = 30
	case 9:
		days = 31
	case 10:
		days = 31
	case 11:
		days = 30
	case 12:
		days = 31
	}
	fmt.Printf("The amount of days in %d/%d are %d\n", month, year, days)
	return
}
