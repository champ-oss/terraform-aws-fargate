package main

import (
	"io/ioutil"
	"testing"
)

func TestOne(t *testing.T) {
	t.Parallel()
	files, err := ioutil.ReadDir("../examples")

	if err != nil {
		t.Log(err)
	}

	for _, f := range files {
		t.Log(f.Name())
	}
}
