import 'package:json_annotation/json_annotation.dart';

part 'account_chart_response_model.g.dart';

@JsonSerializable()
class AccountChartResponse {
  AccountChartResponse({required this.status, required this.data});

  final String status;
  final AccountChartData data;

  factory AccountChartResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountChartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountChartResponseToJson(this);

  @override
  String toString() => 'AccountChartResponse(status: $status, data: $data)';
}

@JsonSerializable()
class AccountChartData {
  AccountChartData({required this.points});

  final List<ChartPoint> points;

  factory AccountChartData.fromJson(Map<String, dynamic> json) =>
      _$AccountChartDataFromJson(json);

  Map<String, dynamic> toJson() => _$AccountChartDataToJson(this);

  @override
  String toString() => 'AccountChartData(points: $points)';
}

@JsonSerializable()
class ChartPoint {
  ChartPoint({
    required this.label,
    required this.accrued,
    required this.paid,
  });

  final String label;
  final double accrued;
  final double paid;

  factory ChartPoint.fromJson(Map<String, dynamic> json) =>
      _$ChartPointFromJson(json);

  Map<String, dynamic> toJson() => _$ChartPointToJson(this);

  @override
  String toString() => 'ChartPoint(label: $label, accrued: $accrued, paid: $paid)';
}
