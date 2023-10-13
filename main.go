package main

import (
	_ "embed"
	"larmic/golang-starter/internal/routers"
	"log"
	"os"
)

//go:embed api/open-api-3.yaml
var openApiYaml string

func main() {
	log.Println("Hello golang starter!")

	externalUrl := os.Getenv("EXTERNAL_URL")
	log.Println("env:	EXTERNAL_URL=", externalUrl)

	if externalUrl == "" {
		log.Fatal("Environment variable EXTERNAL_URL is not set!")
	}

	routersInit := routers.InitRouter(externalUrl, openApiYaml)

	_ = routersInit.Run()
}
