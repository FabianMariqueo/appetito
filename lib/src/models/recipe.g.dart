// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
    id: json['id'] as String,
    userId: json['userId'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    portions: json['portions'] as int,
    procedures: (json['procedures'] as List)?.map((e) => e as String)?.toList(),
    imagesURL: (json['imagesURL'] as List)?.map((e) => e as String)?.toList(),
    ingredients:
        (json['ingredients'] as List)?.map((e) => e as String)?.toList(),
    preparationTime: json['preparationTime'] == null
        ? null
        : DateTime.parse(json['preparationTime'] as String),
  );
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'portions': instance.portions,
      'preparationTime': instance.preparationTime?.toIso8601String(),
      'imagesURL': instance.imagesURL,
      'ingredients': instance.ingredients,
      'procedures': instance.procedures,
    };
