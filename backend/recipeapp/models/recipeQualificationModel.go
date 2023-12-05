package models

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type RecipeQualification struct {
	gorm.Model
	ID       uuid.UUID `gorm:"type:char(36);primary_key;"`
	UserId   string
	RecipeId string
	Score    int32
}
