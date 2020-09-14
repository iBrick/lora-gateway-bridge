package main

import "github.com/iBrick/lora-gateway-bridge/cmd/lora-gateway-bridge/cmd"

var version string // set by the compiler

func main() {
	cmd.Execute(version)
}
