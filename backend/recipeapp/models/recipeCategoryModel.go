package models

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type RecipeCategory struct {
	gorm.Model
	ID         uuid.UUID `gorm:"type:char(36);primary_key;"`
	RecipeId   uuid.UUID `gorm:"type:char(36);"`
	CategoryId uuid.UUID `gorm:"type:char(36);"`
}
