// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procedure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Procedure _$ProcedureFromJson(Map<String, dynamic> json) {
  return Procedure(
    step: json['step'] as int,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$ProcedureToJson(Procedure instance) => <String, dynamic>{
      'step': instance.step,
      'description': instance.description,
    };
