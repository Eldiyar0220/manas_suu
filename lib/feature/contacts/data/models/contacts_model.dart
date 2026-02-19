import 'package:json_annotation/json_annotation.dart';

part 'contacts_model.g.dart';

@JsonSerializable()
class ContactsModel {
  final int id;
  final String name;
  final String email;
  final bool isActive;

  ContactsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) =>
      _$ContactsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsModelToJson(this);
}
