package message

import "testing"

func TestAbc(t *testing.T) {
	if GetMessage() != "Hello World" {
		t.Errorf("Fail to get message")
	}
}
