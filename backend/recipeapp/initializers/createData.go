package initializers

import (
	"recipeapp/models"

	"github.com/google/uuid"
)

func CreateData() {

	memberships := []models.Membership{
		{ID: uuid.New(), Name: "Basic", Level: 1},
		{ID: uuid.New(), Name: "Medium", Level: 2},
		{ID: uuid.New(), Name: "Advance", Level: 3},
	}

	for _, membership := range memberships {
		DB.Create(&membership)
	}
}
