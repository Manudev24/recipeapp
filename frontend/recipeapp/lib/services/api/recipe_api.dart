import 'package:cookingenial/models/IngredientModel.dart';
import 'package:cookingenial/models/category_model.dart';
import 'package:cookingenial/models/recipe_instructions_model.dart';
import 'package:cookingenial/models/recipe_item_model.dart';
import 'package:cookingenial/models/recipe_model.dart';
import 'package:cookingenial/utils/constans.dart';
import 'package:dio/dio.dart';

class RecipeApi {
  static Future<RecipeModel> getRecipesById(String id) async {
    // String? accessToken = await SecureStorage.secureStorage.read(key: "token");

    final dio = Dio(
        // BaseOptions(
        //   headers: {
        //     'Authorization': 'Bearer $accessToken',
        //     'Content-Type': 'application/json',
        //   },
        // ),
        );
    // Response response = await dio.get('$apiUrl/recipe/$id');
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
}
