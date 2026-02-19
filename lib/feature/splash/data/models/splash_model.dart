import 'package:json_annotation/json_annotation.dart';

part 'splash_model.g.dart';

@JsonSerializable()
class SplashModel {
  final int id;
  final String name;
  final String email;
  final bool isActive;

  SplashModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
  });

  factory SplashModel.fromJson(Map<String, dynamic> json) =>
      _$SplashModelFromJson(json);

  Map<String, dynamic> toJson() => _$SplashModelToJson(this);
}
