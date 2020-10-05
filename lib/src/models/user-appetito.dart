import 'package:json_annotation/json_annotation.dart';

part 'user-appetito.g.dart';

@JsonSerializable()
class UserAppetito {
  String uid;
  String email;
  @JsonKey(ignore: true)
  String password;
  String name;
  String description;
  String photoURL;
  UserAppetito(
      {this.uid,
      this.name,
      this.description,
      this.email,
      this.photoURL,
      this.password});

  factory UserAppetito.fromJson(Map<String, dynamic> json) =>
      _$UserAppetitoFromJson(json);

  Map<String, dynamic> toJson() => _$UserAppetitoToJson(this);
}
