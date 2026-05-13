import 'package:json_annotation/json_annotation.dart';

part 'main_model.g.dart';

@JsonSerializable()
class MainModel {
  final int id;
  final String ?name;
  final String? email;
  final bool isActive;

  MainModel({
    required this.id,
     this.name,
     this.email,
    required this.isActive,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) =>
      _$MainModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainModelToJson(this);
}
