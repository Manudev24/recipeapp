import 'package:cookingenial/models/IngredientModel.dart';
import 'package:cookingenial/models/category_model.dart';
import 'package:cookingenial/models/comment_model.dart';
import 'package:cookingenial/models/recipe_instructions_model.dart';
import 'package:cookingenial/models/recipe_item_model.dart';
import 'package:cookingenial/models/recipe_model.dart';
import 'package:cookingenial/models/user_model.dart';
import 'package:cookingenial/services/auth/secure_storage.dart';
import 'package:cookingenial/utils/constans.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class RecipeApi {
  static Future<RecipeModel> getRecipesById(String id) async {
    String? accessToken = await SecureStorage.secureStorage.read(key: "token");

    final dio = Dio(
      BaseOptions(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    try {
      Response response = await dio.get('$apiUrl/recipe/$id');

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;

        RecipeModel recipeModel = RecipeModel(
          id: data['id'],
          name: data['name'],
          description: data['description'],
          note: data['note'],
          qualification: data['qualification'],
          isFavorite: data['isFavorite'],
          favotiteQuantity: data['favoriteQuantity'],
          categories: (data['categories'] as List<dynamic>)
              .map((categoryItem) => CategoryModel(
                    id: categoryItem['id'],
                    name: categoryItem['name'],
                    description: categoryItem['description'],
                  ))
              .toList(),
          items: (data['items'] as List<dynamic>)
              .map((itemItem) => RecipeItemModel(
                    id: itemItem['id'],
                    name: itemItem['name'],
                    ingredients: (itemItem['ingredients'] as List<dynamic>)
                        .map((ingredientItem) => IngredientModel(
                              id: ingredientItem['id'],
                              name: ingredientItem['name'],
                              description: ingredientItem['description'],
                              proportion: ingredientItem['proportion'],
                            ))
                        .toList(),
                  ))
              .toList(),
          instructions: (data['instructions'] as List<dynamic>)
              .map((instructionItem) => RecipeInstructionsModel(
                    stepNumber: instructionItem['stepNumber'],
                    title: instructionItem['title'],
                    description: instructionItem['description'],
                  ))
              .toList(),
        );

        return recipeModel;
      } else {
        throw Exception(
            'Error - Status code: ${response.statusCode}, Message: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  static Future<List<CommentModel>> getAllComments(String id) async {
    final dio = Dio();
    try {
      Response response = await dio.get('$apiUrl/recipe/comments/$id');

      if (response.statusCode == 200) {
        if (response.data == null) {
          return [];
        }
        List<dynamic> dataList = response.data;

        List<CommentModel> comments = dataList.map((data) {
          Map<String, dynamic> userMap = data['user'];
          UserModel user = UserModel(
            id: userMap['id'],
            userName: userMap['userName'],
            firstName: userMap['firstName'],
            lastName: userMap['lastName'],
            membership: userMap['membership'],
          );

          String dateString = data['date'];
          dateString = dateString.substring(
              0, dateString.lastIndexOf(' ')); // Remove timezone

          DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
          DateTime date = dateFormat.parse(dateString);

          return CommentModel(
            id: data['id'],
            description: data['description'],
            score: data['score'],
            date: date,
            user: user,
          );
        }).toList();

        return comments;
      } else {
        throw Exception(
            'Error - Status code: ${response.statusCode}, Message: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  static Future<bool> createComment(
    String recipeId,
    String description,
    int score,
  ) async {
    String? accessToken = await SecureStorage.secureStorage.read(key: "token");

    final dio = Dio(
      BaseOptions(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    final dataToSend = {
      'description': description,
      'score': score,
      'recipeId': recipeId,
    };
    try {
      Response response =
          await dio.post('$apiUrl/recipe/comment', data: dataToSend);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setFavorite(String recipeId, bool status) async {
    String? accessToken = await SecureStorage.secureStorage.read(key: "token");

    final dio = Dio(
      BaseOptions(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    final dataToSend = {
      'recipeId': recipeId,
      'status': status,
    };
    try {
      Response response =
          await dio.post('$apiUrl/recipe/set-favorite', data: dataToSend);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
