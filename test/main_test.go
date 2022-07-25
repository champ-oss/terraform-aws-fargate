package main

import (
	"testing"
)

func TestOne(t *testing.T) {
	t.Parallel()
	t.Log("in test 1")
}

func TestTwo(t *testing.T) {
	t.Parallel()
	t.Log("in test 2!")
}
