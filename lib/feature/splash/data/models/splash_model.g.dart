// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplashModel _$SplashModelFromJson(Map<String, dynamic> json) => SplashModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$SplashModelToJson(SplashModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'isActive': instance.isActive,
    };
