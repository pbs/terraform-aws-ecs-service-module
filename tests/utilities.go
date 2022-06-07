package test

import (
	"fmt"
	"io/ioutil"
	"testing"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/cloudwatchlogs"
	"github.com/aws/aws-sdk-go/service/servicediscovery"
)

func getFileAsString(fileName string) (string, error) {
	content, err := ioutil.ReadFile(fileName)
	if err != nil {
		return "", err
	}

	text := string(content)
	return text, nil
}

func deleteLogGroup(t *testing.T, logGroupName string) {
	session, err := session.NewSession()
	if err != nil {
		t.Fatalf("Failed to create AWS session: %v", err)
	}
	svc := cloudwatchlogs.New(session)
	input := cloudwatchlogs.DeleteLogGroupInput{
		LogGroupName: &logGroupName,
	}
	_, err = svc.DeleteLogGroup(&input)
	if err != nil {
		t.Logf("Failed to delete log group: %v.\nThis is probably OK, as we're just making sure it's not there.", err)
	}
}

func deregisterService(serviceID string) {
	svc := servicediscovery.New(session.New())
	input := &servicediscovery.ListInstancesInput{
		ServiceId: aws.String(serviceID),
	}

	result, err := svc.ListInstances(input)
	if err != nil {
		if aerr, ok := err.(awserr.Error); ok {
			switch aerr.Code() {
			case servicediscovery.ErrCodeServiceNotFound:
				fmt.Println(servicediscovery.ErrCodeServiceNotFound, aerr.Error())
			case servicediscovery.ErrCodeInvalidInput:
				fmt.Println(servicediscovery.ErrCodeInvalidInput, aerr.Error())
			default:
				fmt.Println(aerr.Error())
			}
		} else {
			// Print the error, cast err to awserr.Error to get the Code and
			// Message from an error.
			fmt.Println(err.Error())
		}
		return
	}

	for _, instance := range result.Instances {
		input := &servicediscovery.DeregisterInstanceInput{
			InstanceId: aws.String(*instance.Id),
			ServiceId:  aws.String(serviceID),
		}

		result, err := svc.DeregisterInstance(input)
		if err != nil {
			if aerr, ok := err.(awserr.Error); ok {
				switch aerr.Code() {
				case servicediscovery.ErrCodeDuplicateRequest:
					fmt.Println(servicediscovery.ErrCodeDuplicateRequest, aerr.Error())
				case servicediscovery.ErrCodeInvalidInput:
					fmt.Println(servicediscovery.ErrCodeInvalidInput, aerr.Error())
				case servicediscovery.ErrCodeInstanceNotFound:
					fmt.Println(servicediscovery.ErrCodeInstanceNotFound, aerr.Error())
				case servicediscovery.ErrCodeResourceInUse:
					fmt.Println(servicediscovery.ErrCodeResourceInUse, aerr.Error())
				case servicediscovery.ErrCodeServiceNotFound:
					fmt.Println(servicediscovery.ErrCodeServiceNotFound, aerr.Error())
				default:
					fmt.Println(aerr.Error())
				}
			} else {
				// Print the error, cast err to awserr.Error to get the Code and
				// Message from an error.
				fmt.Println(err.Error())
			}
			return
		}
		fmt.Println(result)
	}
}
