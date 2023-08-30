package initializers

import "recipeapp/models"

func SyncDatabase() {
	DB.AutoMigrate(
		&models.User{},
		&models.Category{},
		&models.DailyRecipe{},
		&models.Ingredient{},
		&models.Language{},
		&models.Membership{},
		&models.Recipe{},
		&models.RecipeDetail{},
	)
}
