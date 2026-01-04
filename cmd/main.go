package main

import (
	"fmt"
	"math"
)

// Test Function
func GetInitMessage() string {
	return "Agent initializing..."
}

func main() {
	msg := GetInitMessage()
	fmt.Println(math.Phi)
	fmt.Println(msg)
}
