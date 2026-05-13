// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetailResponse _$AccountDetailResponseFromJson(
  Map<String, dynamic> json,
) => AccountDetailResponse(
  status: json['status'] as String,
  data: AccountDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AccountDetailResponseToJson(
  AccountDetailResponse instance,
) => <String, dynamic>{'status': instance.status, 'data': instance.data};

AccountDetailData _$AccountDetailDataFromJson(
  Map<String, dynamic> json,
) => AccountDetailData(
  id: (json['id'] as num?)?.toInt(),
  personalAccount: json['personalAccount'] as String?,
  fullName: json['fullName'] as String?,
  address: json['address'] as String?,
  accountType: $enumDecodeNullable(_$AccountTypeEnumMap, json['accountType']),
  balance: (json['balance'] as num?)?.toDouble(),
  registeredCount: (json['registeredCount'] as num?)?.toInt(),
  residentsCount: (json['residentsCount'] as num?)?.toInt(),
  periodLabel: json['periodLabel'] as String?,
  openingBalance: (json['openingBalance'] as num?)?.toDouble(),
  currentPeriodAccrued: (json['currentPeriodAccrued'] as num?)?.toDouble(),
  currentPeriodTax: (json['currentPeriodTax'] as num?)?.toDouble(),
  currentPeriodPaid: (json['currentPeriodPaid'] as num?)?.toDouble(),
  controllerFullName: json['controllerFullName'] as String?,
  services: (json['services'] as List<dynamic>?)
      ?.map((e) => AccountDetailServiceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  controllerPhone: json['controllerPhone'] as String?,
  lastPaymentAmount: (json['lastPaymentAmount'] as num?)?.toDouble(),
  lastPaymentDate: json['lastPaymentDate'] as String?,
);

Map<String, dynamic> _$AccountDetailDataToJson(AccountDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'personalAccount': instance.personalAccount,
      'fullName': instance.fullName,
      'address': instance.address,
      'accountType': _$AccountTypeEnumMap[instance.accountType],
      'balance': instance.balance,
      'registeredCount': instance.registeredCount,
      'residentsCount': instance.residentsCount,
      'periodLabel': instance.periodLabel,
      'openingBalance': instance.openingBalance,
      'currentPeriodAccrued': instance.currentPeriodAccrued,
      'currentPeriodTax': instance.currentPeriodTax,
      'currentPeriodPaid': instance.currentPeriodPaid,
      'controllerFullName': instance.controllerFullName,
      'controllerPhone': instance.controllerPhone,
      'lastPaymentAmount': instance.lastPaymentAmount,
      'lastPaymentDate': instance.lastPaymentDate,
      'services': instance.services,
    };

const _$AccountTypeEnumMap = {
  AccountType.RESIDENTIAL: 'RESIDENTIAL',
  AccountType.COMMERCIAL: 'COMMERCIAL',
};

AccountDetailServiceItem _$AccountDetailServiceItemFromJson(
  Map<String, dynamic> json,
) => AccountDetailServiceItem(
  name: json['name'] as String?,
  volume: (json['volume'] as num?)?.toInt(),
  cubicMeters: (json['cubicMeters'] as num?)?.toDouble(),
  tariff: (json['tariff'] as num?)?.toDouble(),
  amount: (json['amount'] as num?)?.toDouble(),
  tax: (json['tax'] as num?)?.toDouble(),
  total: (json['total'] as num?)?.toDouble(),
);

Map<String, dynamic> _$AccountDetailServiceItemToJson(
  AccountDetailServiceItem instance,
) => <String, dynamic>{
  'name': instance.name,
  'volume': instance.volume,
  'cubicMeters': instance.cubicMeters,
  'tariff': instance.tariff,
  'amount': instance.amount,
  'tax': instance.tax,
  'total': instance.total,
};
