// Copyright © 2016 Alan A. A. Donovan & Brian W. Kernighan.
// License: https://creativecommons.org/licenses/by-nc-sa/4.0/
// ADDITIONAL AUTHOR: Evan M. Krimpenfort

// See page 99.

// Graph shows how to use a map of maps to represent a directed graph.
// Digraph program now implements Dijkstra's Algorithm
package main

import (
	"fmt"
	"os"
	"bufio"
)

//!+
var graph = make(map[string]map[string]int)
var Strs []string
const Inf = 1000000

func addEdge(from, to string, weight int) {
	edges := graph[from]
	if edges == nil {
		edges = make(map[string]int)
		graph[from] = edges
	}
	edges[to] = weight
	addString(from)
	addString(to)
}

func addString(str string) {
	isPresent := false
	for _, s := range Strs {
		if s == str {
			isPresent = true
		}
	}
	if !isPresent {
		Strs = append(Strs, str)
	}
}

func getClosestNonVisited(weights map[string]int, visited []string) string {
	closest := Inf
	closestString := ""

	for str, weight := range weights {
		isVisited := false
		for _, visitedString := range visited {
			if str == visitedString {
				isVisited = true
			}
		}

		if !isVisited {
			if (weight < closest) {
				closest = weight
				closestString = str
			}
		}
	}

	return closestString
}

func makeWeightTable(start string) map[string]int {
	weights := make(map[string]int)
	weights[start] = 0

	for _, s := range Strs {
		if start != s {
			weights[s] = Inf
		}
	}

	return weights
}

func findPath(start string) string {
	shortestPathTable := ""
	weights := makeWeightTable(start)
	var visited []string

	for len(visited) != len(Strs) {
		str := getClosestNonVisited(weights, visited)
		visited = append(visited, str)
		for edgeStr, weight := range graph[str] {
			weightToNeighbor := weights[str] + weight
			if weightToNeighbor < weights[edgeStr] {
				weights[edgeStr] = weightToNeighbor
			}
		}
	}

	for str, weight := range weights {
		if weight != Inf {
			shortestPathTable += fmt.Sprintf("shortest distance from %s to %s: %d\n", start, str, weight)
		} else {
			shortestPathTable += fmt.Sprintf("shortest distance from %s to %s: Infiniti\n", start, str)
		}
	}

	return shortestPathTable
}

//!-

func main() {
	//
	// READ FROM FILE
	//
	filename := os.Args[1]
	list, err := os.Open(filename)

	if err != nil {
		fmt.Println("Error reading file w/ error %s.", err)
		os.Exit(1)
	}

	defer list.Close()
	scanner := bufio.NewScanner(list)
	source := ""
	destination := ""
	weight := 0

	for scanner.Scan() {
		line := scanner.Text()
		_, err := fmt.Sscanf(line, "%s %s %d", &source, &destination, &weight)
		if err != nil {
			fmt.Printf("Error reading file w/ error %s.", err)
			os.Exit(1)
		}
		addEdge(source, destination, weight)
	}

	//
	// Print whats found
	//
	for s, dmap := range graph {
		fmt.Printf("%s: [ ", s)
		for d, w := range dmap {
			fmt.Printf("%s[%d] ", d, w)
		}
		fmt.Printf("]\n")
	}

	//
	// FIND THE PATH
	//
	start := ""
	fmt.Printf("start node? ")
	fmt.Scanf("%s", &start)
	fmt.Println(findPath(start))
}
