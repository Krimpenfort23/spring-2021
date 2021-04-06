// 
// Question 4
// Homework 7
// Author: Evan Krimpenfort
//

package main

import (
	"fmt"
	"sort"
)

func main() {
	exit := true
	students := make(map[string]string)
	for exit {
		option := 0
		fmt.Printf("Welcome to course grades. Would you like to...\n(1)\tAdd or Remove Students?\n(2)\tModify Grades?\n(3)\tPrint all Student grades?\n\t\t-or-\n(4)\tExit?\n$ ")
		fmt.Scanf("%d", &option)

		// go through the options
		switch option {
		case 1:
			// add or remove students
			option1 := 0
			fmt.Printf("Would you like to Add or Remove a Student?\n(1)\tAdd\n(2)\tRemove\n\t\t-or-\n(3)\tBack...\n$ ")
			fmt.Scanf("%d", &option1)

			// go through the options1
			switch option1 {
			case 1:
				name := ""
				grade := ""
				fmt.Printf("Enter the name of the Student and his grade. [name grade]\n$ ")
				fmt.Scanf("%s %s", &name, &grade)
				students[name] = grade
			case 2:
				name := ""
				fmt.Printf("Enter the name of the Student you wish to erase.\n$ ")
				fmt.Scanf("%s", &name)
				delete(students, name)
			case 3:
				continue
			default:
				continue
			}
		case 2:
			// modify a students grade
			name := ""
			grade := ""
			fmt.Printf("Which Student's grade would you like to modify and to what grade? [name grade]\n$ ")
			fmt.Scanf("%s %s", &name, &grade)
			students[name] = grade
		case 3:
			// print sorted names
			names := make([]string, 0, len(students))
			for name := range students {
				names = append(names, name)
			}
			sort.Strings(names)	// sorting

			for _, name := range names {
				fmt.Printf("%s: %s\n", name, students[name])
			}
		case 4:
			// end program
			exit = false
		default:
			// bad input
			fmt.Println("\nNot an option...\n")
		}
	}
	return
}
