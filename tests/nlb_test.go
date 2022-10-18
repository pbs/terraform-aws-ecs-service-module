package test

import (
	"testing"
)

func TestNLBExample(t *testing.T) {
	if testing.Short() {
		t.Skip("skipping testing in short mode")
	}
	testECSService(t, "nlb")
}
