package main

import (
	"recipeapp/controllers"
	"recipeapp/initializers"
	"recipeapp/middleware"

	"github.com/gin-gonic/gin"
)

func init() {
	initializers.LoadEnvVariables()
	initializers.ConnectToDb()
	initializers.SyncDatabase()
	initializers.CreateData()
}

func main() {
	r := gin.Default()
	r.POST("/signup", controllers.SignUp)
	r.POST("/login", controllers.Login)
	r.POST("/validate", middleware.RequireAuth, controllers.Validate)
	r.POST("/changeUserPassword", middleware.RequireAuth, controllers.ChangePassword)
	r.Run()
}
