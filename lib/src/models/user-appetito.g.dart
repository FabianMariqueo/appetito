// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-appetito.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAppetito _$UserAppetitoFromJson(Map<String, dynamic> json) {
  return UserAppetito(
    uid: json['uid'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    email: json['email'] as String,
    photoURL: json['photoURL'] as String,
  );
}

Map<String, dynamic> _$UserAppetitoToJson(UserAppetito instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'description': instance.description,
      'photoURL': instance.photoURL,
    };
