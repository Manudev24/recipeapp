package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type DailyRecipe struct {
	gorm.Model
	ID       uuid.UUID `gorm:"type:char(36);primary_key;"`
	userId   string
	RecipeId string
	date     time.Time
}
