package models

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type RecipeDetail struct {
	gorm.Model
	ID              uuid.UUID `gorm:"type:char(36);primary_key;"`
	recipeId        string
	ingredientId    string
	quantity        float32
	measurementUnit string
}
