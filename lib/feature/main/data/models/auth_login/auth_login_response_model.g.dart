// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginResponseModel _$AuthLoginResponseModelFromJson(
  Map<String, dynamic> json,
) => AuthLoginResponseModel(
  data: AuthLoginDataModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthLoginResponseModelToJson(
  AuthLoginResponseModel instance,
) => <String, dynamic>{'data': instance.data.toJson()};

AuthLoginDataModel _$AuthLoginDataModelFromJson(Map<String, dynamic> json) =>
    AuthLoginDataModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      fullName: json['fullName'] as String?,
      personalAccount: json['personalAccount'] as String?,
    );

Map<String, dynamic> _$AuthLoginDataModelToJson(AuthLoginDataModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'fullName': instance.fullName,
      'personalAccount': instance.personalAccount,
    };
