// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_chart_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountChartResponse _$AccountChartResponseFromJson(
  Map<String, dynamic> json,
) => AccountChartResponse(
  status: json['status'] as String,
  data: AccountChartData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AccountChartResponseToJson(
  AccountChartResponse instance,
) => <String, dynamic>{'status': instance.status, 'data': instance.data};

AccountChartData _$AccountChartDataFromJson(Map<String, dynamic> json) =>
    AccountChartData(
      points: (json['points'] as List<dynamic>)
          .map((e) => ChartPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountChartDataToJson(AccountChartData instance) =>
    <String, dynamic>{'points': instance.points};

ChartPoint _$ChartPointFromJson(Map<String, dynamic> json) => ChartPoint(
  label: json['label'] as String,
  accrued: (json['accrued'] as num).toDouble(),
  paid: (json['paid'] as num).toDouble(),
);

Map<String, dynamic> _$ChartPointToJson(ChartPoint instance) =>
    <String, dynamic>{
      'label': instance.label,
      'accrued': instance.accrued,
      'paid': instance.paid,
    };
