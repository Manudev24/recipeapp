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
	//User
	r.POST("/signup", controllers.SignUp)
	r.POST("/login", controllers.Login)
	r.POST("/loadData", middleware.RequireAuth, controllers.LoadData)
	r.POST("/changeUserPassword", middleware.RequireAuth, controllers.ChangePassword)
	r.POST("/user/image/:id", controllers.PostUserImage)
	r.GET("/user/image/:id", controllers.GetUserImage)

	//TODO: Add Middleware
	//Recipe
	r.POST("/recipe", controllers.CreateRecipe)
	r.GET("/recipe/:id", middleware.RequireAuth, controllers.GetRecipeById)
	r.GET("/search/:parameter", controllers.GetRecipesByParameter)
	r.GET("/recipe/get-image/:id", controllers.GetRecipeImage)
	r.GET("/recipe/get-video/:id", controllers.GetRecipeVideo)
	r.POST("/recipe/comment", middleware.RequireAuth, controllers.PostComment)
	r.GET("/recipe/comments/:id", controllers.GetComments)
	r.POST("/recipe/set-favorite", middleware.RequireAuth, controllers.SetFavorite)

	//Categories
	r.GET("/randomCategories", controllers.GetRandomCategories)
	r.GET("/allCategories", controllers.GetAllCategories)
	r.GET("/category/get-image/:id", controllers.GetCategoryImage)
	r.POST("/category", controllers.PostCategory)

	//Ingredient
	r.POST("/ingredient", controllers.PostIngredient)
	r.GET("/ingredient/get-image/:id", controllers.GetIngredientImage)
	r.POST("/ingredient/post-image/:id", controllers.PostIngredientImage)

	r.Run()
}
