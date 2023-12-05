package models

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type ItemIngredient struct {
	gorm.Model
	ID           uuid.UUID `gorm:"type:char(36);primary_key;"`
	RecipeItemId uuid.UUID `gorm:"type:char(36);"`
	IngredientId uuid.UUID `gorm:"type:char(36);"`
	Proportion   string
}
