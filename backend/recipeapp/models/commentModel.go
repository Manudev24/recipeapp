package models

Type Comment struct {
	ID          uuid.UUID `gorm:"type:char(36);primary_key;"`
	UserId      uuid.UUID `gorm:"type:char(36);"`
	RecipeId    uuid.UUID `gorm:"type:char(36);"`
	Date        string
	Description string
	Score       int
}
