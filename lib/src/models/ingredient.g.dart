// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) {
  return Ingredient(
    name: json['name'] as String,
    measureUnit: json['measureUnit'] as String,
    quantity: json['quantity'] as String,
  );
}

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'measureUnit': instance.measureUnit,
    };
