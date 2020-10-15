package test

import (
	"math/rand"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

var letterRunes = []rune("abcdefghijklmnopqrstuvwxyz1234567890")

func RandStringRunes(n int) string {
	rand.Seed(time.Now().UnixNano())
	b := make([]rune, n)
	for i := range b {
		b[i] = letterRunes[rand.Intn(len(letterRunes))]
	}
	return string(b)
}

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	testNamePrefix := "eg-test"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	cfDomainName := terraform.Output(t, terraformOptions, "cf_domain_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "example.com", cfDomainName)

	// Run `terraform output` to get the value of an output variable
	cfArn := terraform.Output(t, terraformOptions, "cf_arn")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, cfArn, "arn:aws:cloudfront::")
}
