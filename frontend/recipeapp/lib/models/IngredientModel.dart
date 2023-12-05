class IngredientModel {
  String id;
  String name;
  String? description;
  String? proportion;

  IngredientModel({
    required this.id,
    required this.name,
    this.description,
    this.proportion,
  });
}
