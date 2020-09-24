import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  String id;
  String userId;
  String name;
  String description;
  int portions;
  DateTime preparationTime;
  @JsonKey(ignore: true)
  List<Future<PickedFile>> imagesFiles = [];
  List<String> imagesURL = [];
  List<String> ingredients = [];
  List<String> procedures = [];

  Recipe(
      {this.id,
      this.userId,
      this.name,
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
