package models

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type User struct {
	gorm.Model
	ID              uuid.UUID `gorm:"type:char(36);primary_key;"`
	UserName        string    `gorm:"unique"`
	FirstName       string
	LastName        string
	Password        string
	PasswordVersion uuid.UUID `gorm:"type:char(36)"`
	MembershipId    string
	LanguageId      string
}
