package main

import (
	"day04/solution1"
	"fmt"
	"os"
)

func main() {
	// solutionOne()
	overlaps := 0
	buffer := readFile()
	input := solution1.ParseInput(buffer)

	for _, slice := range input {
		if solution1.ContainsOverlap(slice[0], slice[1]) {
			overlaps++
		}
	}
	fmt.Printf("%d\n", overlaps)
}

func solutionOne() {
	fullyContains := 0
	buffer := readFile()
	input := solution1.ParseInput(buffer)

	for _, slice := range input {
		if solution1.FullyContains(slice[0], slice[1]) {
			fullyContains++
		}
	}
	fmt.Printf("%d\n", fullyContains)
}

func readFile() string {
	data, err := os.ReadFile("/tmp/test.vim")
	if err != nil {
		panic(err)
	}
	return string(data)
}
