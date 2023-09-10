package models

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type RecipeDetail struct {
	gorm.Model
	ID              uuid.UUID `gorm:"type:char(36);primary_key;"`
	RecipeId        string
	IngredientId    string
	Quantity        float32
	MeasurementUnit string
}
