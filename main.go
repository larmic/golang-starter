package main

import (
	"larmic/golang-starter/internal/routers"
	"log"
	"os"
)

func main() {
	log.Println("Hello golang starter!")

	externalUrl := os.Getenv("EXTERNAL_URL")

	if externalUrl == "" {
		log.Fatal("Environment variable EXTERNAL_URL is not set!")
	}

	routersInit := routers.InitRouter(externalUrl)

	_ = routersInit.Run()
}
