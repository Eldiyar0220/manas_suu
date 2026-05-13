import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  final int? id;
  final String? name;
  final String? email;
  final bool? isActive;

  SettingsModel({
    this.id,
    this.name,
    this.email,
    this.isActive,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);
}
