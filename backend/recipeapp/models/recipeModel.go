package models

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Recipe struct {
	gorm.Model
	ID            uuid.UUID `gorm:"type:char(36);primary_key;"`
	CategoryId    string
	userId        string
	Name          string `gorm:"unique"`
	Description   string
	Instructions  string
	Time          string
	difficulty    int32
	qualification float32
}
