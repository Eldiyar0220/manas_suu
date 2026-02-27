import 'package:json_annotation/json_annotation.dart';

part 'accounts_response_model.g.dart';

@JsonEnum()
enum AccountType { RESIDENTIAL, COMMERCIAL }

@JsonSerializable()
class AccountsResponseModel {
  const AccountsResponseModel({required this.status, required this.data});

  final String status;
  final List<AccountItemModel> data;

  factory AccountsResponseModel.fromJson(Map<String, dynamic> json) => _$AccountsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountsResponseModelToJson(this);
}

@JsonSerializable()
class AccountItemModel {
  const AccountItemModel({
    required this.id,
    required this.personalAccount,
    required this.fullName,
    required this.address,
    required this.accountType,
    required this.balance,
    this.registeredCount,
    this.residingCount,
  });

  final int id;
  final String personalAccount;
  final String fullName;
  final String address;
  final AccountType accountType;
  final double balance;
  final int? registeredCount;
  @JsonKey(name: 'residentsCount')
  final int? residingCount;

  factory AccountItemModel.fromJson(Map<String, dynamic> json) => _$AccountItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountItemModelToJson(this);
}
