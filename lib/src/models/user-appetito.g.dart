// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-appetito.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAppetito _$UserAppetitoFromJson(Map<String, dynamic> json) {
  return UserAppetito(
    uid: json['uid'] as String,
    nombre: json['nombre'] as String,
    email: json['email'] as String,
    photoURL: json['photoURL'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserAppetitoToJson(UserAppetito instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'password': instance.password,
      'nombre': instance.nombre,
      'photoURL': instance.photoURL,
    };
