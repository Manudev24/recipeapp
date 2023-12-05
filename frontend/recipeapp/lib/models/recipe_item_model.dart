import 'package:cookingenial/models/IngredientModel.dart';

class RecipeItemModel {
  String id;
  String name;
  List<IngredientModel> ingredients;

  RecipeItemModel({
    required this.id,
    required this.name,
    required this.ingredients,
  });
}
