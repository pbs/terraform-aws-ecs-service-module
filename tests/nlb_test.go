package test

import (
	"testing"
)

func TestNLBExample(t *testing.T) {
	testECSService(t, "nlb")
}
