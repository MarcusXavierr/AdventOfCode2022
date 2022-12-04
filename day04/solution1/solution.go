package solution1

import (
	"strconv"
	"strings"
)

func ParseInput(buffer string) (pairs [][][]int) {
	bufferPairs := strings.Split(buffer, "\n")
	for _, buffPair := range bufferPairs {
		if buffPair != "" {
			pairs = append(pairs, MakePair(buffPair))
		}
	}
	return pairs
}

func FullyContains(a, b []int) bool {
	return subset(a, b) || subset(b, a)
}

func MakePair(buffer string) (pairs [][]int) {
	items := strings.Split(buffer, ",")
	for _, item := range items {
		pairs = append(pairs, CreateSection(item))
	}
	return
}

func CreateSection(input string) []int {
	numbers := strings.Split(input, "-")
	min, max := getMinAndMaxRange(numbers)

	return makeRange(min, max)
}

func ContainsOverlap(a, b []int) bool {
	result := false
	for _, item := range a {
		result = result || contains(b, item)
	}
	return result
}
func subset(first, second []int) bool {
	set := make(map[int]int)
	for _, value := range second {
		set[value] += 1
	}

	for _, value := range first {
		if count, found := set[value]; !found {
			return false
		} else if count < 1 {
			return false
		} else {
			set[value] = count - 1
		}
	}

	return true
}

func contains(s []int, e int) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

func getMinAndMaxRange(numbers []string) (min int, max int) {
	min, minE := strconv.Atoi(numbers[0])
	max, maxE := strconv.Atoi(numbers[1])
	check(minE)
	check(maxE)

	return

}
func makeRange(min, max int) []int {
	a := make([]int, max-min+1)
	for i := range a {
		a[i] = min + i
	}
	return a
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}
