package solution1

import (
	"reflect"
	"testing"
)

type SectionTest struct {
	input string
	want  []int
}

func TestCreateSection(t *testing.T) {
	assertRight := func(t testing.TB, input string, want []int) {
		t.Helper()
		got := CreateSection(input)
		if !reflect.DeepEqual(got, want) {
			t.Errorf("got %v want %v, input %q", got, want, input)
		}
	}

	sectionTests := []struct {
		input string
		want  []int
	}{
		{"2-4", []int{2, 3, 4}},
		{"1-6", []int{1, 2, 3, 4, 5, 6}},
		{"6-8", []int{6, 7, 8}},
		{"10-13", []int{10, 11, 12, 13}},
	}
	for _, tt := range sectionTests {
		assertRight(t, tt.input, tt.want)
	}
}

func TestAssignmentFullyContainsAnother(t *testing.T) {
	assertRight := func(first, second []int, want bool, t testing.TB) {
		t.Helper()
		got := FullyContains(first, second)

		if got != want {
			t.Errorf("got %t, but want %t\ninput A %v, input B %v", got, want, first, second)
		}
	}

	slicesTest := []struct {
		a, b []int
		want bool
	}{
		{[]int{2, 3}, []int{1, 2, 3, 4}, true},
		{[]int{2, 3, 4, 5, 6}, []int{1, 2, 3, 4}, false},
		{[]int{2, 3, 4, 5, 6, 7, 8}, []int{3, 4, 5, 6, 7}, true},
		{[]int{6}, []int{4, 5, 6}, true},
	}

	for _, slice := range slicesTest {
		assertRight(slice.a, slice.b, slice.want, t)
	}
}

func TestMakePair(t *testing.T) {
	input := "2-4,6-8"
	got := MakePair(input)
	want := [][]int{{2, 3, 4}, {6, 7, 8}}

	if !reflect.DeepEqual(got, want) {
		t.Errorf("got %v, but want %v. Input %q", got, want, input)
	}
}

func TestParseInput(t *testing.T) {
	input := "2-4,3-5\n6-6,6-8\n"
	got := ParseInput(input)
	want := [][][]int{{{2, 3, 4}, {3, 4, 5}}, {{6}, {6, 7, 8}}}

	if !reflect.DeepEqual(got, want) {
		t.Errorf("got: %v\nwant: %v", got, want)
	}
}

func TestContainsAnyOverlap(t *testing.T) {
	assertRight := func(fst []int, snd []int, want bool, t testing.TB) {
		t.Helper()
		got := ContainsOverlap(fst, snd)
		if got != want {
			t.Errorf("got %t, but want %t\ninput A %v, input B %v", got, want, fst, snd)
		}
	}

	containsTests := []struct {
		fst, snd []int
		want     bool
	}{
		{[]int{5, 6, 7}, []int{7, 8, 9}, true},
		{[]int{2, 3, 4, 5, 6}, []int{4, 5, 6, 7, 8}, true},
		{[]int{2, 3, 4}, []int{6, 7, 8}, false},
	}
	for _, test := range containsTests {
		assertRight(test.fst, test.snd, test.want, t)

	}
}
