// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsModel _$ContactsModelFromJson(Map<String, dynamic> json) =>
    ContactsModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$ContactsModelToJson(ContactsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'isActive': instance.isActive,
    };
