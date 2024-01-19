import 'package:cookingenial/models/category_model.dart';
import 'package:cookingenial/models/recipe_instructions_model.dart';
import 'package:cookingenial/models/recipe_item_model.dart';

class RecipeModel {
  String id;
  String name;
  String? description;
  String? note;
  num? qualification;
  bool? isFavorite;
  int? favotiteQuantity;

  //Detail
  List<RecipeItemModel>? items;
  List<RecipeInstructionsModel>? instructions;
  List<CategoryModel>? categories;

  RecipeModel({
    required this.id,
    required this.name,
    this.description,
    this.note,
    this.qualification,
    this.instructions,
    this.isFavorite,
    this.favotiteQuantity,
    this.items,
    this.categories,
  });
}
