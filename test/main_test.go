package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
)

func TestMain(m *testing.M) {
	fmt.Println("start init")

	t = *testing.T

	terraformOptions := &terraform.Options{TerraformDir: ".."}
	defer terraform.Destroy(testing.TestingT, terraformOptions)
	terraform.InitAndApplyAndIdempotent(t, terraformOptions)

	terraform.
		fmt.Println("end init")
}

func TestOne(t *testing.T) {
	t.Parallel()

	fmt.Println("in test 1")
}

func TestTwo(t *testing.T) {
	t.Parallel()

	fmt.Println("in test 2!")
}
