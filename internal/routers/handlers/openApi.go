package handlers

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"os"
)

func GetOpenApi(c *gin.Context) {
	c.Header("Content-Type", "text/yaml; charset=UTF-8")
	c.Status(http.StatusOK)
	dat, _ := os.ReadFile("open-api-3.yaml")
	_, _ = c.Writer.Write(dat)
}
