package models

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Favorite struct {
	gorm.Model
	ID       uuid.UUID `gorm:"type:char(36);primary_key;"`
	UserId   uuid.UUID `gorm:"type:char(36);"`
	RecipeId uuid.UUID `gorm:"type:char(36);"`
}
