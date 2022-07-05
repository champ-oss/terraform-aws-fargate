package test

import (
	"fmt"
	"testing"
	"time"
)

func init() {
	fmt.Println("start init")
	time.Sleep(8 * time.Second)
	fmt.Println("end init")
}

func TestOne(t *testing.T) {
	t.Parallel()

	fmt.Println("in test 1")
	t.Log("in test 1")
}

func TestTwo(t *testing.T) {
	t.Parallel()

	fmt.Println("in test 2")
	t.Log("in test 2!")
}
