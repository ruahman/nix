package main

import (
	"fmt"

	cowsay "github.com/Code-Hex/Neo-cowsay/v2"
)

func main() {
	// Basic usage
	cow, err := cowsay.Say("Hello, Go!", cowsay.Type("default"), cowsay.BallonWidth(40))
	if err != nil {
		panic(err)
	}
	fmt.Println(cow)

	// Example with different cow type
	dragon, err := cowsay.Say("Hello, Dragon!", cowsay.Type("dragon"), cowsay.BallonWidth(40))
	if err != nil {
		panic(err)
	}
	fmt.Println(dragon)
}
