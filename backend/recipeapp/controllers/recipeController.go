package controllers

import (
	"encoding/json"
	"fmt"
	"gorm.io/gorm"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"recipeapp/initializers"
	"recipeapp/models"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

//array inputs

type RecipeItem struct {
	Name        string                 `json:"name"`
	Ingredients []RecipeItemIngredient `json:"ingredients"`
}

type RecipeItemIngredient struct {
	Id         string `json:"id"`
	Proportion string `json:"proportion"`
}

type RecipeInstruction struct {
	StepNumber  int32  `json:"stepNumber"`
	Title       string `json:"title"`
	Description string `json:"description"`
}

//arrays output

type IngredientResponse struct {
	ID          string `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description"`
	Proportion  string `json:"proportion"`
}

type RecipeItemResponse struct {
	ID          string               `json:"id"`
	Name        string               `json:"name"`
	Ingredients []IngredientResponse `json:"ingredients"`
}

type RecipeInstructionResponse struct {
	StepNumber  int32  `json:"stepNumber"`
	Title       string `json:"title"`
	Description string `json:"description"`
}

type RecipeCategoryResponse struct {
	ID          string `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description"`
}

type RecipeResponse struct {
	ID                string                      `json:"id"`
	Name              string                      `json:"name"`
	Description       string                      `json:"description"`
	Note              string                      `json:"note"`
	RecipeCategory    []RecipeCategoryResponse    `json:"categories"`
	RecipeItem        []RecipeItemResponse        `json:"items"`
	RecipeInstruction []RecipeInstructionResponse `json:"instructions"`
	Qualification     float32                     `json:"qualification"`
}

func CreateRecipe(c *gin.Context) {

	// Genera un UUID para la receta
	recipeID := uuid.New()

	//Get the body
	var body struct {
		//Single
		Name        string `form:"name"`
		Description string `form:"description"`
		Note        string `form:"note"`

		//Arrays
		Categories   string `form:"categories"`
		Instructions string `form:"instructions"`
		Items        string `form:"items"`
	}

	if err := c.Bind(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to read body",
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

	// Process video
	videoFile, _, err := c.Request.FormFile("video")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to read video file",
		})
		return
	}
	defer videoFile.Close()

	//Get categories string from body
	jsonCategoryIdStr := body.Categories
	var strCategoryIdList []string
	categoryParseErr := json.Unmarshal([]byte(jsonCategoryIdStr), &strCategoryIdList)
	if categoryParseErr != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to load categories",
		})
		return
	}

	//Create categories for recipe
	for _, categoryId := range strCategoryIdList {
		var category models.Category
		if err := initializers.DB.First(&category, uuid.MustParse(categoryId)).Error; err != nil {
			if err != gorm.ErrRecordNotFound {
				c.JSON(http.StatusBadRequest, gin.H{
					"error": "Failed to find category",
				})
				return
			}
		}

		recipeCategory := models.RecipeCategory{
			ID:         uuid.New(),
			RecipeId:   recipeID,
			CategoryId: uuid.MustParse(categoryId),
		}

		if err := initializers.DB.Create(&recipeCategory).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"error": "Failed to save category to recipe",
			})
			return
		}
	}

	//Get Instructions from body
	jsonInstructionStr := body.Instructions
	var strInstructionList []RecipeInstruction
	instructionParseErr := json.Unmarshal([]byte(jsonInstructionStr), &strInstructionList)
	if instructionParseErr != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to load instruction",
		})
		return
	}

	//Create Instructions for recipe
	for _, instruction := range strInstructionList {

		result := initializers.DB.Create(&models.RecipeInstruction{
			ID:          uuid.New(),
			RecipeId:    recipeID,
			StepNumber:  instruction.StepNumber,
			Title:       instruction.Title,
			Description: instruction.Description,
		})

		if result.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"error": "Failed to save instruction to recipe",
			})
			return
		}
	}

	//Get Items from body
	jsonItemsStr := body.Items
	var strItemsList []RecipeItem
	ItemsParseErr := json.Unmarshal([]byte(jsonItemsStr), &strItemsList)
	if ItemsParseErr != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to load items",
		})
		return
	}

	//Create items for recipe
	for _, item := range strItemsList {

		itemID := uuid.New()
		for _, itemIngredient := range item.Ingredients {
			result := initializers.DB.Create(&models.ItemIngredient{
				ID:           uuid.New(),
				RecipeItemId: itemID,
				IngredientId: uuid.MustParse(itemIngredient.Id),
				Proportion:   itemIngredient.Proportion,
			})

			if result.Error != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"error": "Failed to save item",
				})
				return
			}
		}

		result := initializers.DB.Create(&models.RecipeItem{
			ID:       itemID,
			Name:     item.Name,
			RecipeId: recipeID,
		})

		if result.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"error": "Failed to save item to recipe",
			})
			return
		}
	}

	//Create Recipe with file paths
	recipe := models.Recipe{
		ID:          recipeID,
		Name:        body.Name,
		Description: body.Description,
		Note:        body.Note,
	}

	result := initializers.DB.Create(&recipe)

	if result.Error != nil {
		fmt.Println(result.Error)
		initializers.DB.Delete(&recipe)
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to create recipe",
		})
		return
	}

	imageFileName := recipeID.String() + ".jpg"
	imagePath := filepath.Join("files/recipe/images", imageFileName)
	imageDestination, err := os.Create(imagePath)
	if err != nil {
		initializers.DB.Delete(&recipe)
		c.JSON(http.StatusInternalServerError, gin.H{
			"Error": "Failed to save image",
		})
		return
	}
	defer imageDestination.Close()

	_, err = io.Copy(imageDestination, imageFile)
	if err != nil {
		initializers.DB.Delete(&recipe)
		c.JSON(http.StatusInternalServerError, gin.H{
			"Error": "Failed to save image",
		})
		return
	}

	videoFileName := recipeID.String() + ".mp4"
	videoPath := filepath.Join("files/recipe/videos", videoFileName)
	videoDestination, err := os.Create(videoPath)
	if err != nil {
		initializers.DB.Delete(&recipe)
		c.JSON(http.StatusInternalServerError, gin.H{
			"Error": "Failed to save video",
		})
		return
	}
	defer videoDestination.Close()

	_, err = io.Copy(videoDestination, videoFile)
	if err != nil {
		initializers.DB.Delete(&recipe)
		c.JSON(http.StatusInternalServerError, gin.H{
			"Error": "Failed to save video",
		})
		return
	}

	// Respond
	c.JSON(http.StatusCreated, gin.H{})
}

func GetRecipeById(c *gin.Context) {

	//Get the ID
	id := c.Param("id")

	//Find the recipe
	var recipe models.Recipe
	if err := initializers.DB.First(&recipe, uuid.MustParse(id)).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			c.JSON(http.StatusNotFound, gin.H{
				"Error": "Recipe not found",
			})
			return
		}
	}

	var recipeItem []models.RecipeItem
	if err := initializers.DB.Find(&recipeItem).Where("recipe_id = ?", id).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			c.JSON(http.StatusNotFound, gin.H{
				"Error": "Recipe not found",
			})
			return
		}
	}

	var recipeItemIngredient []models.ItemIngredient
	if err := initializers.DB.Find(&recipeItemIngredient).Where("recipe_id = ?", id).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			c.JSON(http.StatusNotFound, gin.H{
				"Error": "Recipe Item Ingredient not found",
			})
			return
		}
	}

	var recipeInstruction []models.RecipeInstruction
	if err := initializers.DB.Order("step_number asc").Find(&recipeInstruction).Where("recipe_id = ?", id).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			c.JSON(http.StatusNotFound, gin.H{
				"Error": "Recipe instructions not found",
			})
			return
		}
	}

	var recipeCategoryResponse []RecipeCategoryResponse
	query := `
				select categories.id,categories.name,categories.description from categories join recipe_categories 
				on recipe_categories.category_id = categories.id
				join recipes on recipes.id = recipe_categories.recipe_id where recipes.id = ?
	`

	if err := initializers.DB.Raw(query, id).Scan(&recipeCategoryResponse).Error; err != nil {
		fmt.Println("Error to load categories", err)
		return
	}

	var recipeItemResponse []RecipeItemResponse
	for _, item := range recipeItem {
		var ingredientResponse []IngredientResponse
		query := `
		SELECT ingredients.id, ingredients.name, ingredients.description, item_ingredients.proportion
		FROM ingredients
		JOIN item_ingredients ON ingredients.id = item_ingredients.ingredient_id
		WHERE item_ingredients.recipe_item_id = ?`

		if err := initializers.DB.Raw(query, item.ID.String()).Scan(&ingredientResponse).Error; err != nil {
			fmt.Println("Error to load ingredients:", err)
			return
		}

		recipeItemResponse = append(recipeItemResponse, RecipeItemResponse{
			ID:          item.ID.String(),
			Name:        item.Name,
			Ingredients: ingredientResponse,
		})
	}

	var recipeInstructionResponse []RecipeInstructionResponse
	for _, instruction := range recipeInstruction {
		recipeInstructionResponse = append(recipeInstructionResponse, RecipeInstructionResponse{
			StepNumber:  instruction.StepNumber,
			Title:       instruction.Title,
			Description: instruction.Description,
		})
	}

	var recipeResponse RecipeResponse
	recipeResponse = RecipeResponse{
		ID:                recipe.ID.String(),
		Name:              recipe.Name,
		Description:       recipe.Description,
		Note:              recipe.Note,
		RecipeCategory:    recipeCategoryResponse,
		RecipeItem:        recipeItemResponse,
		RecipeInstruction: recipeInstructionResponse,
		Qualification:     0.0,
	}
	// Respond
	c.JSON(http.StatusOK, recipeResponse)
}

func GetRecipeImage(c *gin.Context) {

	id := c.Param("id")
	imagePath := filepath.Join("files/recipe/images", id+".jpg")
	if _, err := os.Stat(imagePath); err == nil {
		c.File(imagePath)
	} else {
		c.JSON(http.StatusNotFound, gin.H{
			"error": "Image not found",
		})
	}
}

func GetRecipeVideo(c *gin.Context) {

	id := c.Param("id")
	videoPath := filepath.Join("files/recipe/videos", id+".mp4")
	if _, err := os.Stat(videoPath); err == nil {
		c.File(videoPath)
	} else {
		c.JSON(http.StatusNotFound, gin.H{
			"error": "Video not found",
		})
	}
}

func GetRecipesByParameter(c *gin.Context) {
	parameter := c.Param("parameter")

	// user, _ := c.Get("user")
	// if user.(models.User).ID == uuid.Nil {
	// 	c.JSON(http.StatusBadRequest, gin.H{
	// 		"error": "Usuario no válido",
	// 	})
	// 	return
	// }

	// TODO: Agregar camel case
	var recipes []struct {
		ID            uuid.UUID `json:"id"`
		Name          string    `json:"name"`
		Qualification float64   `json:"qualification"`
	}

	if err := initializers.DB.Model(&models.Recipe{}).
		Select("id, name, qualification").
		Where("name LIKE ?", "%"+parameter+"%").
		Limit(30).
		Scan(&recipes).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": "Error to load recipes",
		})
		return
	}

	if len(recipes) == 0 {
		c.JSON(http.StatusOK, []struct{}{})
		return
	}

	c.JSON(http.StatusOK, recipes)
}
