import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  final int id;
  final String name;
  final String email;
  final bool isActive;

  SettingsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);
}
