package router_user

import (
	"github.com/gin-gonic/gin"
	"go-demo/api_user"
)

func SetupRouter() *gin.Engine {
	r := gin.Default()

	api := r.Group("/api")
	{
		api.POST("/users", api_user.CreateUser)
		api.GET("/users", api_user.GetUsers)
	}

	return r
}
