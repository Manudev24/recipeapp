package models

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Recipe struct {
	gorm.Model
	ID            uuid.UUID `gorm:"type:char(36);primary_key;"`
	CategoryId    string
	SserId        string
	Name          string `gorm:"unique"`
	Description   string
	Instructions  string
	Time          string
	Difficulty    int32
	Qualification float32
}
