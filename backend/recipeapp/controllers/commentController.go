package controllers

import (
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"net/http"
	"recipeapp/initializers"
	"recipeapp/models"
)

// Post one comment to a recipe
func PostComment(c *gin.Context) {

	user, _ := c.Get("user")

	var body struct {
		RecipeId    string `form:"recipeId"`
		Description string `form:"description"`
		Score       int    `form:"score"`
	}

	if err := c.Bind(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"Error": "Failed to read body",
		})
		return
	}

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

		//Only one comment per user and recipe
		var count int64
		initializers.DB.Model(&models.Comment{}).Where("user_id = ? AND recipe_id = ?", userResponse.Id, body.RecipeId).Count(&count)

		if count > 0 {
			c.JSON(http.StatusBadRequest, gin.H{
				"error": "You already commented this recipe",
			})
			return
		}

		//Create the comment
		newComment := models.Comment{
			ID:          uuid.New(),
			UserId:      u.ID,
			RecipeId:    uuid.MustParse(body.RecipeId),
			Description: body.Description,
			Score:       body.Score,
		}

		if err := initializers.DB.Create(&newComment).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"error": "Failed to save comment",
			})
			return
		}

		c.JSON(http.StatusCreated, gin.H{})

	} else {
		c.JSON(http.StatusUnauthorized, gin.H{})
	}

}

// Get all comments from a recipe
func GetComments(c *gin.Context) {
	recipeID := c.Param("id")

	type UserResponse struct {
		Id         string `json:"id"`
		UserName   string `json:"userName"`
		FirstName  string `json:"firstName"`
		LastName   string `json:"lastName"`
		Membership string `json:"membership"`
	}
	//GET ALL COMMENTS
	var comments []models.Comment
	//join user
	if err := initializers.DB.Find(&comments).Where("recipe_id = ?", recipeID).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": "Error to load comments",
		})
		return
	}

	type CommentsResponse struct {
		ID          uuid.UUID    `json:"id"`
		Date        string       `json:"date"`
		Description string       `json:"description"`
		Score       int          `json:"score"`
		User        UserResponse `json:"user"`
	}

	var commentsResponse []CommentsResponse
	for _, comment := range comments {

		var user models.User
		if err := initializers.DB.Find(&user).Where("user_id = ?", user.ID).Error; err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"error": "Error to load comments",
			})
			return
		}
		commentsResponse = append(commentsResponse, CommentsResponse{
			ID:          comment.ID,
			Date:        comment.CreatedAt.String(),
			Description: comment.Description,
			Score:       comment.Score,
			User: UserResponse{
				Id:        user.ID.String(),
				UserName:  user.UserName,
				FirstName: user.FirstName,
				LastName:  user.LastName,
			},
		})
	}

	c.JSON(http.StatusOK, commentsResponse)

}

// Ger one random comment from a recipe
func GetRandomComment(c *gin.Context) {

	user, _ := c.Get("user")

	recipeID := c.Param("id")

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

		//GET ALL COMMENTS
		var comments []models.Comment
		if err := initializers.DB.Find(&comments).Where("user_id = ? AND recipe_id = ?", userResponse.Id, recipeID).Error; err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"error": "Error to load user comment",
			})
			return
		}

		if len(comments) == 0 {
			c.JSON(http.StatusOK, []struct{}{})
			return
		}

		type CommentsResponse struct {
			ID          uuid.UUID    `json:"id"`
			Date        string       `json:"date"`
			Description string       `json:"description"`
			Score       int          `json:"score"`
			User        UserResponse `json:"user"`
		}

		var commentsResponse []CommentsResponse
		for _, comment := range comments {
			commentsResponse = append(commentsResponse, CommentsResponse{
				ID:          comment.ID,
				Date:        comment.CreatedAt.String(),
				Description: comment.Description,
				Score:       comment.Score,
				User:        userResponse,
			})
		}

		c.JSON(http.StatusOK, commentsResponse)

	} else {
		c.JSON(http.StatusUnauthorized, gin.H{})
	}

}
