package initializers

import "recipeapp/models"

func SyncDatabase() {
	DB.AutoMigrate(
		&models.Category{},
		&models.Favorite{},
		&models.Ingredient{},
		&models.ItemIngredient{},
		&models.Language{},
		&models.Membership{},
		&models.Recipe{},
		&models.RecipeCategory{},
		&models.RecipeInstruction{},
		&models.RecipeItem{},
		&models.RecipeQualification{},
		&models.User{},
	)
}
