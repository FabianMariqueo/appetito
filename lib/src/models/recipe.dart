import 'package:appetito/src/models/ingredient.dart';
import 'package:appetito/src/models/procedure.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  String name;
  String description;
  int portions;
  DateTime preparationTime;
  List<dynamic> imagesFiles;
  List<String> imagesURL;
  List<Ingredient> ingredients;
  List<Procedure> procedures;

  Recipe(
      {this.name,
      this.description,
      this.portions,
      this.procedures,
      this.imagesFiles,
      this.imagesURL,
      this.ingredients,
      this.preparationTime});

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
