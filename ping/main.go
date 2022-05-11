package main

import (
	"fmt"
	"os"
	"time"
)

func main() {
	counter := 0

	name := os.Getenv("NAME")

	for {
		_, err := fmt.Fprintf(os.Stdout, "%s: message number %d\n", name, counter)
		if err != nil {
			panic(err)
		}

		counter++

		time.Sleep(time.Second * 1)
	}
}
