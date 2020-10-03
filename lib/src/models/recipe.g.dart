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
    category: json['category'] as String,
    portions: json['portions'] as int,
    procedures: (json['procedures'] as List)?.map((e) => e as String)?.toList(),
    imagesURL: (json['imagesURL'] as List)?.map((e) => e as String)?.toList(),
    ingredients:
        (json['ingredients'] as List)?.map((e) => e as String)?.toList(),
    preparationTime: json['preparationTime'] == null
        ? null
        : DateTime.parse(json['preparationTime'] as String),
  )..createdAt = json['createdAt'] as int;
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'portions': instance.portions,
      'preparationTime': instance.preparationTime?.toIso8601String(),
      'createdAt': instance.createdAt,
      'imagesURL': instance.imagesURL,
      'ingredients': instance.ingredients,
      'procedures': instance.procedures,
    };
