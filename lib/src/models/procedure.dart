import 'package:json_annotation/json_annotation.dart';

part 'procedure.g.dart';

@JsonSerializable()
class Procedure {
  int step;
  String description;

  Procedure({this.step, this.description});

  factory Procedure.fromJson(Map<String, dynamic> json) =>
      _$ProcedureFromJson(json);

  Map<String, dynamic> toJson() => _$ProcedureToJson(this);
}
