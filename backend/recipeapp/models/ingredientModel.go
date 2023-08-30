package models

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Ingredient struct {
	gorm.Model
	ID   uuid.UUID `gorm:"type:char(36);primary_key;"`
	Name string    `gorm:"unique"`
}
