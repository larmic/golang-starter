package handlers

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func GetOpenApi(openApiYaml string) gin.HandlerFunc {
	fn := func(c *gin.Context) {
		c.Header("Content-Type", "text/yaml; charset=UTF-8")
		c.Status(http.StatusOK)
		_, _ = c.Writer.Write([]byte(openApiYaml))
	}
	return fn
}
