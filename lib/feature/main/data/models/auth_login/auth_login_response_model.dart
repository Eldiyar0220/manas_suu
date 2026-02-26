import 'package:json_annotation/json_annotation.dart';

part 'auth_login_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthLoginResponseModel {
  const AuthLoginResponseModel({
    required this.data,
  });

  final AuthLoginDataModel data;

  factory AuthLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthLoginResponseModelToJson(this);
}

@JsonSerializable()
class AuthLoginDataModel {
  const AuthLoginDataModel({
    required this.accessToken,
    required this.refreshToken,
    required this.fullName,
    required this.personalAccount,
  });

  final String accessToken;
  final String refreshToken;
  final String fullName;
  final String personalAccount;

  factory AuthLoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthLoginDataModelToJson(this);
}
