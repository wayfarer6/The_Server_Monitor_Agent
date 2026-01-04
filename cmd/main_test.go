package main

import "testing"

func TestEntryPoint(t *testing.T) {
	expected := "Agent initializing..."
	actual := GetInitMessage()

	if actual != expected {
		t.Errorf("결과가 다릅니다. 받은 값: %s, 기대한 값: %s", actual, expected)
	}
}
