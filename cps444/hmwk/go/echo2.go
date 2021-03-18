// Copyright © 2016 Alan A. A. Donovan & Brian W. Kernighan.
// License: https://creativecommons.org/licenses/by-nc-sa/4.0/

// See page 6.
//!+

// Echo2 prints its command-line arguments.
// Program now prints out the command line arguments alongside their repsective index
// Modifier: Evan Krimpenfort
package main

import (
	"fmt"
	"os"
)

func main() {
	i := 1
	for _, arg := range os.Args[1:] {
		fmt.Printf("%s i=%d\n", arg, i)
		i++
	}
}

//!-
