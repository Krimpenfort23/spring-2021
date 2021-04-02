//
// Question 14
// Homework 6
// Author: Evan Krimpenfort
//
package main

import(
	"fmt"
	"math/rand"
	"math"
)

func main() {
	bet := 1
	dice1 := 0
	dice2 := 0
	total := 0
	winnings := 0
	for i:=0; i<24; i++ {
		dice1 = int(math.Floor((rand.Float64() * 6) + 1))
		dice2 = int(math.Floor((rand.Float64() * 6) + 1))
		total = dice1+dice2
		fmt.Printf("roll 1: %d roll 2: %d total: %d\n", dice1, dice2, total)
		if (total == 12) {
			winnings += bet
		}
	}
	fmt.Printf("Total winnings: %d\n", winnings)
	return
}
