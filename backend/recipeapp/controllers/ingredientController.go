package controllers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"recipeapp/initializers"
	"recipeapp/models"
)

func PostIngredient(c *gin.Context) {

	var body struct {
		Name        string `form:"name"`
		Description string `form:"description"`
	}

	if c.Bind(&body) != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to read body",
		})
		return
	}

	//Create ID
	ingredientID := uuid.New()

	// Process image
	imageFile, _, err := c.Request.FormFile("image")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to read image file",
		})
		return
	}
	defer imageFile.Close()

	ingredient := models.Ingredient{
		ID:          ingredientID,
		Name:        body.Name,
		Description: body.Description,
	}

	result := initializers.DB.Create(&ingredient)

	if result.Error != nil {
		fmt.Println(result.Error)
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to create ingredient",
		})
	}

	imageFileName := ingredientID.String() + ".jpg"
	imagePath := filepath.Join("files/ingredient/images", imageFileName)
	imageDestination, err := os.Create(imagePath)
	if err != nil {
		initializers.DB.Delete(&ingredient)
		c.JSON(http.StatusInternalServerError, gin.H{
			"Error": "Failed to save image",
		})
		return
	}
	defer imageDestination.Close()

	_, err = io.Copy(imageDestination, imageFile)
	if err != nil {
		initializers.DB.Delete(&ingredient)
		c.JSON(http.StatusInternalServerError, gin.H{
			"Error": "Failed to save image",
		})
		return
	}
	//Respond
	c.JSON(http.StatusCreated, gin.H{})
}

func GetIngredientImage(c *gin.Context) {

	id := c.Param("id")
	imagePath := filepath.Join("files/ingredient/images", id+".jpg")
	if _, err := os.Stat(imagePath); err == nil {
		c.File(imagePath)
	} else {
		c.JSON(http.StatusNotFound, gin.H{
			"error": "Image not found",
		})
	}
}

func PostIngredientImage(c *gin.Context) {

	id := c.Param("id")

	ingredient := models.Ingredient{}
	result := initializers.DB.Where("id = ?", id).First(&ingredient)

	if result.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{
			"error": "Ingredient not found",
		})
		return
	}

	// Process image
	imageFile, _, err := c.Request.FormFile("image")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to read image file",
		})
		return
	}
	defer imageFile.Close()

	imageFileName := id + ".jpg"
	imagePath := filepath.Join("files/ingredient/images", imageFileName)
	imageDestination, err := os.Create(imagePath)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"Error": "Failed to save image",
		})
		return
	}
	defer imageDestination.Close()

	_, err = io.Copy(imageDestination, imageFile)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"Error": "Failed to save image",
		})
		return
	}
	//Respond
	c.JSON(http.StatusCreated, gin.H{})
}
