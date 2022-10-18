package test

import (
	"testing"
)

func TestAppMeshExample(t *testing.T) {
	if testing.Short() {
		t.Skip("skipping testing in short mode")
	}
	testECSService(t, "am")
}
