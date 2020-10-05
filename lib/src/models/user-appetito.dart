import 'package:json_annotation/json_annotation.dart';

part 'user-appetito.g.dart';

@JsonSerializable()
class UserAppetito {
  final String uid;
  String email;
  String password;
  String nombre;
  String photoURL;
  UserAppetito(
      {this.uid, this.nombre, this.email, this.photoURL, this.password});

  factory UserAppetito.fromJson(Map<String, dynamic> json) =>
      _$UserAppetitoFromJson(json);

  Map<String, dynamic> toJson() => _$UserAppetitoToJson(this);
}
