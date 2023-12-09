package controllers

import (
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"recipeapp/initializers"
	"recipeapp/models"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

func SignUp(c *gin.Context) {

	//Get the phone and password

	var body struct {
		UserName  string `json:"userName"`
		FirstName string `json:"firstName"`
		LastName  string `json:"lastName"`
		Password  string `json:"password"`
	}

	if c.Bind(&body) != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to read body",
		})

		return
	}

	if body.FirstName == "" || body.LastName == "" || body.UserName == "" || body.Password == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Empty fields",
		})
		return
	}

	//Hash the password

	hash, err := bcrypt.GenerateFromPassword([]byte(body.Password), 10)

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to hash password",
		})

		return
	}

	var membership models.Membership
	initializers.DB.First(&membership, "level = ?", 1)

	membershipId := membership.ID.String()

	//Create User
	user := models.User{
		ID:              uuid.New(),
		UserName:        body.UserName,
		FirstName:       body.FirstName,
		LastName:        body.LastName,
		Password:        string(hash),
		PasswordVersion: uuid.New(),
		MembershipId:    membershipId,
	}

	result := initializers.DB.Create(&user)

	if result.Error != nil {
		fmt.Println(result.Error)
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to create user",
		})
	}
	//Respond
	c.JSON(http.StatusCreated, gin.H{})
}

func Login(c *gin.Context) {

	//Get the userName and pass of the body
	var body struct {
		UserName string `json:"userName"`
		Password string `json:"password"`
	}

	if c.Bind(&body) != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to read body",
		})

		return
	}

	// look up requested user
	var user models.User
	initializers.DB.First(&user, "user_name = ?", body.UserName)

	if user.ID == uuid.Nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Invalid user",
		})

		return
	}

	//Compare sent in pass with saved user pass hash

	err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(body.Password))

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Invalid user name or password",
		})

		return
	}

	//Generate jwt
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"sub":         user.ID,
		"exp":         time.Now().Add(time.Hour * 24 * 30).Unix(),
		"pwd_version": user.PasswordVersion,
	})

	// Sign and get the complete encoded token as a string using the secret
	tokenString, err := token.SignedString([]byte(os.Getenv("SECRET")))

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to create token",
		})

		return
	}

	//Sent it back
	c.JSON(http.StatusOK, gin.H{
		"token": tokenString,
	})
}

func ChangePassword(c *gin.Context) {

	var body struct {
		CurrentPassword string
		NewPassword     string
	}

	if c.Bind(&body) != nil {
		fmt.Println(body)
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to read body",
		})
		return
	}

	user, _ := c.Get("user")
	if user.(models.User).ID == uuid.Nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Invalid user",
		})
		return
	}

	// Hash the new password
	hash, err := bcrypt.GenerateFromPassword([]byte(body.NewPassword), 10)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to hash password",
		})
		return
	}

	// Compare the current password with the stored hashed password
	if err := bcrypt.CompareHashAndPassword([]byte(user.(models.User).Password), []byte(body.CurrentPassword)); err != nil {
		c.JSON(http.StatusUnprocessableEntity, gin.H{
			"error": "Incorrect current password",
		})
		return
	}

	// Change the password and save the user in the database
	if u, ok := user.(models.User); ok {
		u.Password = string(hash)
		u.PasswordVersion = uuid.New()
		result := initializers.DB.Save(&u)

		if result.Error != nil {
			fmt.Println(result.Error)
			c.JSON(http.StatusBadRequest, gin.H{
				"error": "Failed to change the password",
			})
			return
		}

		// Respond with a success message
		c.JSON(http.StatusOK, gin.H{})
	} else {
		fmt.Println(ok)
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to load user",
		})
	}
}

func LoadData(c *gin.Context) {

	user, _ := c.Get("user")

	if u, ok := user.(models.User); ok {

		type UserResponse struct {
			Id         string `json:"id"`
			UserName   string `json:"userName"`
			FirstName  string `json:"firstName"`
			LastName   string `json:"lastName"`
			Membership string `json:"membership"`
		}

		var membership models.Membership
		initializers.DB.First(&membership, "id = ?", u.MembershipId)

		var userResponse UserResponse

		userResponse.Id = u.ID.String()
		userResponse.UserName = u.UserName
		userResponse.FirstName = u.FirstName
		userResponse.LastName = u.LastName
		userResponse.Membership = membership.Name

		c.JSON(http.StatusOK, userResponse)

	} else {
		c.JSON(http.StatusUnauthorized, gin.H{})
	}

}

func PostUserImage(c *gin.Context) {
	id := c.Param("id")

	file, err := c.FormFile("image")

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to read file",
		})
		return
	}

	if err := c.SaveUploadedFile(file, filepath.Join("files/user/images", id+".jpg")); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Failed to save file",
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{})
}

func GetUserImage(c *gin.Context) {

	id := c.Param("id")
	imagePath := filepath.Join("files/user/images", id+".jpg")
	if _, err := os.Stat(imagePath); err == nil {
		c.File(imagePath)
	} else {
		c.JSON(http.StatusNotFound, gin.H{
			"error": "Image not found",
		})
	}
}
