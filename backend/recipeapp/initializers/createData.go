package initializers

import (
	"recipeapp/models"

	"github.com/google/uuid"
)

func CreateData() {

	memberships := []models.Membership{
		{ID: uuid.New(), Name: "Basic", Level: 1},
		{ID: uuid.New(), Name: "Medium", Level: 2},
		{ID: uuid.New(), Name: "Advance", Level: 3},
	}

	categories := []models.Category{
		{ID: uuid.New(), Name: "Desayuno"},
		{ID: uuid.New(), Name: "Almuerzo"},
		{ID: uuid.New(), Name: "Cena"},
		{ID: uuid.New(), Name: "Aperitivos"},
		{ID: uuid.New(), Name: "Postres"},
		{ID: uuid.New(), Name: "Bocadillos"},
		{ID: uuid.New(), Name: "Rápida"},
		{ID: uuid.New(), Name: "Casera"},
		{ID: uuid.New(), Name: "Gourmet"},
		{ID: uuid.New(), Name: "Vegetariana"},
		{ID: uuid.New(), Name: "Vegana"},
		{ID: uuid.New(), Name: "Sin gluten"},
		{ID: uuid.New(), Name: "Sin lactosa"},
		{ID: uuid.New(), Name: "Saludable"},
		{ID: uuid.New(), Name: "Picante"},
		{ID: uuid.New(), Name: "A la parrilla"},
		{ID: uuid.New(), Name: "Al horno"},
		{ID: uuid.New(), Name: "Frita"},
		{ID: uuid.New(), Name: "Asada"},
		{ID: uuid.New(), Name: "Al vapor"},
		{ID: uuid.New(), Name: "Cruda"},
		{ID: uuid.New(), Name: "Enlatada"},
		{ID: uuid.New(), Name: "Congelada"},
		{ID: uuid.New(), Name: "Para llevar"},
		{ID: uuid.New(), Name: "Para niños"},
		{ID: uuid.New(), Name: "Para ancianos"},
		{ID: uuid.New(), Name: "Ocasiones especiales"},
		{ID: uuid.New(), Name: "Picnics"},
		{ID: uuid.New(), Name: "Fiestas"},
	}

	for _, membership := range memberships {
		DB.Create(&membership)
	}

	for _, category := range categories {
		DB.Create(&category)
	}
}
