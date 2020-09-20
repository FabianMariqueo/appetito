// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
    name: json['name'] as String,
    description: json['description'] as String,
    portions: json['portions'] as int,
    procedures: (json['procedures'] as List)
        ?.map((e) =>
            e == null ? null : Procedure.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    imagesFiles: json['imagesFiles'] as List,
    imagesURL: (json['imagesURL'] as List)?.map((e) => e as String)?.toList(),
    ingredients: (json['ingredients'] as List)
        ?.map((e) =>
            e == null ? null : Ingredient.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    preparationTime: json['preparationTime'] == null
        ? null
        : DateTime.parse(json['preparationTime'] as String),
  );
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'portions': instance.portions,
      'preparationTime': instance.preparationTime?.toIso8601String(),
      'imagesFiles': instance.imagesFiles,
      'imagesURL': instance.imagesURL,
      'ingredients': instance.ingredients,
      'procedures': instance.procedures,
    };
