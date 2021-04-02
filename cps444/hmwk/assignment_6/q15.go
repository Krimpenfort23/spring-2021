//
// Question 15
// Homework 6
// Author: Evan Krimpenfort
//
package main

import(
	"fmt"
	"strconv"
	"unicode/utf8"
)

func main() {
	input := ""
	fmt.Printf("Enter an eight diget card #: ")
	fmt.Scanf("%s", &input)
	var card = []rune(input)

	buf := make([]byte, 1)
	num := 0
	sum1 := 0
	for i:=1; i<8; i+=2 {
		_ = utf8.EncodeRune(buf, card[i])
		num, _ = strconv.Atoi(string(buf))
		sum1 += num
	}
	fmt.Println(sum1)

	sum2 := 0
	r := 0
	part := ""
	for i:=0; i<8; i+=2 {
		_ = utf8.EncodeRune(buf, card[i])
		num, _ = strconv.Atoi(string(buf))
		num *= 2
		part = strconv.Itoa(num)
		rpart := []rune(part)

		for j:=0; j<len(rpart); j++ {
			_ = utf8.EncodeRune(buf, rpart[j])
			r, _ = strconv.Atoi(string(buf))
			sum2 += r
		}
	}
	fmt.Println(sum2)

	if ((sum1 + sum2) % 10 == 0) {
		fmt.Println("Card Valid.")
	} else {
		fmt.Println("Card is NOT Valid.")
	}
	return
}
