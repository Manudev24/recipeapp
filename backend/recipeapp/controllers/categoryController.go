package controllers

import (
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"recipeapp/initializers"
	"recipeapp/models"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

func GetRandomCategories(c *gin.Context) {
	// user, _ := c.Get("user")
	// if user.(models.User).ID == uuid.Nil {
	// 	c.JSON(http.StatusBadRequest, gin.H{
	// 		"error": "Usuario no válido",
	// 	})
	// 	return
	// }

	var categories []struct {
		ID          uuid.UUID `json:"id"`
		Name        string    `json:"name"`
		Description string    `json:"description"`
	}

	if err := initializers.DB.Model(&models.Category{}).Raw("SELECT * FROM categories ORDER BY RAND() LIMIT 8").Scan(&categories).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": "Error to load categories",
		})
		return
	}

	if len(categories) == 0 {
		c.JSON(http.StatusOK, []struct{}{})
		return
	}

	c.JSON(http.StatusOK, categories)
}

func GetAllCategories(c *gin.Context) {
	// user, _ := c.Get("user")
	// if user.(models.User).ID == uuid.Nil {
	// 	c.JSON(http.StatusBadRequest, gin.H{
	// 		"error": "Usuario no válido",
	// 	})
	// 	return
	// }

	var categories []models.Category
	if err := initializers.DB.Find(&categories).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": "Error to load categories",
		})
		return
	}

	if len(categories) == 0 {
		c.JSON(http.StatusOK, []struct{}{})
		return
	}

	type CategoriesResponse struct {
		ID          uuid.UUID `json:"id"`
		Name        string    `json:"name"`
		Description string    `json:"description"`
	}

	var categoriesResponse []CategoriesResponse
	for _, category := range categories {
		categoriesResponse = append(categoriesResponse, CategoriesResponse{
			ID:          category.ID,
			Name:        category.Name,
			Description: category.Description,
		})
	}

	c.JSON(http.StatusOK, categoriesResponse)
}

func GetCategoryImage(c *gin.Context) {

	id := c.Param("id")
	imagePath := filepath.Join("files/category/images", id+".jpg")
	if _, err := os.Stat(imagePath); err == nil {
		c.File(imagePath)
	} else {
		c.JSON(http.StatusNotFound, gin.H{
			"error": "Image not found",
		})
	}
}

func PostCategory(c *gin.Context) {

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

	category := models.Category{
		ID:          uuid.New(),
		Name:        body.Name,
		Description: body.Description,
	}

	result := initializers.DB.Create(&category)

	if result.Error != nil {
		fmt.Println(result.Error)
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to create category",
		})
	}
	//Respond
	c.JSON(http.StatusCreated, gin.H{})
}
