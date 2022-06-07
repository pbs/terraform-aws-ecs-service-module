package test

import (
	"net/http"
	"testing"
)

func TestAppMeshExample(t *testing.T) {
	resp, err := http.Get("https://github.com/pbs/terraform-aws-ecs-service-module")
	if err != nil || resp.StatusCode != 200 {
		t.Skip("Skipping test because ECS module repo is not open sourced yet")
	}
	testECSService(t, "am")
}
