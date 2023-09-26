package handlers

import (
	"github.com/gin-gonic/gin"
	"larmic/golang-starter/internal/client"
	"net/http"
)

func GetExternalCall(externalUrl string) gin.HandlerFunc {
	fn := func(c *gin.Context) {
		proxyClient := client.NewDelegateClient(externalUrl)
		response := proxyClient.GetExternalStuff()
		c.IndentedJSON(http.StatusOK, response)
	}
	return fn
}
