package models

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type RecipeInstruction struct {
	gorm.Model
	ID          uuid.UUID `gorm:"type:char(36);primary_key;"`
	RecipeId    uuid.UUID `gorm:"type:char(36);"`
	StepNumber  int32
	Title       string
	Description string
}
