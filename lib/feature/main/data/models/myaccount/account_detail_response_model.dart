import 'package:json_annotation/json_annotation.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';

part 'account_detail_response_model.g.dart';

@JsonSerializable()
class AccountDetailResponse {
  AccountDetailResponse({required this.status, required this.data});

  final String status;
  final AccountDetailData data;

  factory AccountDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDetailResponseToJson(this);
}

@JsonSerializable()
class AccountDetailData {
  AccountDetailData({
    this.id,
    this.personalAccount,
    this.fullName,
    this.address,
    this.accountType,
    this.balance,
    this.registeredCount,
    this.residentsCount,
    this.periodLabel,
    this.openingBalance,
    this.currentPeriodAccrued,
    this.currentPeriodTax,
    this.currentPeriodPaid,
    this.controllerFullName,
    this.services,
    this.controllerPhone,
    this.lastPaymentAmount,
    this.lastPaymentDate,
  });

  final int? id;
  final String? personalAccount;
  final String? fullName;
  final String? address;
  final AccountType? accountType;
  final double? balance;
  final int? registeredCount;
  @JsonKey(name: 'residentsCount')
  final int? residentsCount;
  final String? periodLabel;
  final double? openingBalance;
  final double? currentPeriodAccrued;
  final double? currentPeriodTax;
  final double? currentPeriodPaid;
  final String? controllerFullName;
  final String? controllerPhone;
  final double? lastPaymentAmount;
  final String? lastPaymentDate;
  final List<AccountDetailServiceItem>? services;

  factory AccountDetailData.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDetailDataToJson(this);
}

@JsonSerializable()
class AccountDetailServiceItem {
  AccountDetailServiceItem({
    this.name,
    this.volume,
    this.cubicMeters,
    this.tariff,
    this.amount,
    this.tax,
    this.total,
  });

  final String? name;
  final int? volume;
  final double? cubicMeters;
  final double? tariff;
  final double? amount;
  final double? tax;
  final double? total;

  factory AccountDetailServiceItem.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailServiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDetailServiceItemToJson(this);
}
