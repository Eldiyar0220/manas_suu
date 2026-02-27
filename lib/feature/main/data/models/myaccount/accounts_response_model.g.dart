// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsResponseModel _$AccountsResponseModelFromJson(
  Map<String, dynamic> json,
) => AccountsResponseModel(
  status: json['status'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => AccountItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AccountsResponseModelToJson(
  AccountsResponseModel instance,
) => <String, dynamic>{'status': instance.status, 'data': instance.data};

AccountItemModel _$AccountItemModelFromJson(Map<String, dynamic> json) =>
    AccountItemModel(
      id: (json['id'] as num).toInt(),
      personalAccount: json['personalAccount'] as String,
      fullName: json['fullName'] as String,
      address: json['address'] as String,
      accountType: $enumDecode(_$AccountTypeEnumMap, json['accountType']),
      balance: (json['balance'] as num).toDouble(),
      registeredCount: (json['registeredCount'] as num?)?.toInt(),
      residingCount: (json['residentsCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AccountItemModelToJson(AccountItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'personalAccount': instance.personalAccount,
      'fullName': instance.fullName,
      'address': instance.address,
      'accountType': _$AccountTypeEnumMap[instance.accountType]!,
      'balance': instance.balance,
      'registeredCount': instance.registeredCount,
      'residentsCount': instance.residingCount,
    };

const _$AccountTypeEnumMap = {
  AccountType.RESIDENTIAL: 'RESIDENTIAL',
  AccountType.COMMERCIAL: 'COMMERCIAL',
};
