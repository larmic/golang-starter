package routers

import (
	"github.com/gin-gonic/gin"
	"larmic/golang-starter/internal/handlers"
)

func InitRouter(externalUrl string) *gin.Engine {
	r := gin.New()
	_ = r.SetTrustedProxies(nil)
	r.Use(gin.Logger())
	r.Use(gin.Recovery())

	r.GET("/", handlers.GetOpenApi)

	api := r.Group("/api")
	api.GET("/external", handlers.GetExternalCall(externalUrl))
	api.GET("/", handlers.GetOpenApi)

	return r
}
