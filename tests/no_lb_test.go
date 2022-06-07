package test

import (
	"testing"
)

func TestNoLBExample(t *testing.T) {
	testECSService(t, "no-lb")
}
