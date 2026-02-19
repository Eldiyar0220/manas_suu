// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainModel _$MainModelFromJson(Map<String, dynamic> json) => MainModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$MainModelToJson(MainModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'isActive': instance.isActive,
};
