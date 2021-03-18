// Copyright © 2016 Alan A. A. Donovan & Brian W. Kernighan.
// License: https://creativecommons.org/licenses/by-nc-sa/4.0/

// See page 10.
//!+

// Dup2 prints the count and text of lines that appear more than once
// in the input.  It reads from stdin or from a list of named files.
// Modified dup2 to print the names of all files in which each duplicated line occurs.
// Modifer: Evan Krimpenfort
package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	counts := make(map[string]map[string]int)	// created a larger map to include filename
	files := os.Args[1:]
	if len(files) == 0 {
		countLines(os.Stdin, "os.Stdin", counts)// arg here is technically just one and thats os.Stdin
	} else {
		for _, arg := range files {
			f, err := os.Open(arg)
			if err != nil {
				fmt.Fprintf(os.Stderr, "dup2: %v\n", err)
				continue
			}
			countLines(f, arg, counts)	// arg here is which ever file the loop is currently in
			f.Close()
		}
	}
	for line, args := range counts {	// modifed this loop to encorporate the extended map
		argCount := len(args)
		if argCount == 1 {
			total := 0
			for _, count := range args {
				total += count
			}
			if total <= 1 {	// if its 1 or less, then there are no repeats between itself and other files
				continue
			}
		}

		fmt.Printf("found in %d files \t'%s'\n", argCount, line)
		for name, count := range args {	// added loop for the next part of the map which is the map[string]int
			fmt.Printf("\t%d hits in '%s'\n", count, name)
		}
	}
}

func countLines(f *os.File, arg string, counts map[string]map[string]int) {	// expanded the function to incorporate the argument value for the bigger map
	input := bufio.NewScanner(f)
	for input.Scan() {
		if counts[input.Text()] == nil {	// checks to see if the second map of strings has been made 
			counts[input.Text()] = make(map[string]int)
		}
		counts[input.Text()][arg]++
	}
}

//!-
