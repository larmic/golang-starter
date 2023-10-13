package routers

import (
	"github.com/gin-gonic/gin"
	"larmic/golang-starter/internal/routers/handlers"
)

func InitRouter(externalUrl string, openApiYaml string) *gin.Engine {
	r := gin.New()
	_ = r.SetTrustedProxies(nil)
	r.Use(gin.Logger())
	r.Use(gin.Recovery())

	r.GET("/", handlers.GetOpenApi(openApiYaml))

	api := r.Group("/api")
	api.GET("/external", handlers.GetExternalCall(externalUrl))
	api.GET("/", handlers.GetOpenApi(openApiYaml))

	return r
}
