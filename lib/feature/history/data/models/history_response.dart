class HistoryResponse {
  HistoryResponse({required this.status, required this.data});

  final String status;
  final HistoryData data;

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      status: json['status'] as String? ?? '',
      data: HistoryData.fromJson(
        json['data'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'data': data.toJson()};
}

class HistoryData {
  HistoryData({
    required this.personalAccount,
    required this.fullName,
    required this.address,
    this.periods = const [],
  });

  final String personalAccount;
  final String fullName;
  final String address;
  final List<HistoryModel> periods;

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    final rawPeriods = json['periods'];
    final list = rawPeriods is List ? rawPeriods : const [];

    return HistoryData(
      personalAccount: json['personalAccount'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      address: json['address'] as String? ?? '',
      periods: list
          .whereType<Map<String, dynamic>>()
          .map(HistoryModel.fromJson)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'personalAccount': personalAccount,
    'fullName': fullName,
    'address': address,
    'periods': periods.map((e) => e.toJson()).toList(),
  };
}

class HistoryModel {
  HistoryModel({
    required this.periodYear,
    required this.periodMonth,
    required this.periodLabel,
    required this.openingBalance,
    required this.accrued,
    required this.paid,
    required this.closingBalance,
    this.services = const [],
  });

  final int periodYear;
  final int periodMonth;
  final String periodLabel;
  final double openingBalance;
  final double accrued;
  final double paid;
  final double closingBalance;
  final List<HistoryService> services;

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    final rawServices = json['services'];
    final list = rawServices is List ? rawServices : const [];

    return HistoryModel(
      periodYear: json['periodYear'] as int? ?? 0,
      periodMonth: json['periodMonth'] as int? ?? 0,
      periodLabel: json['periodLabel'] as String? ?? '',
      openingBalance: (json['openingBalance'] as num?)?.toDouble() ?? 0.0,
      accrued: (json['accrued'] as num?)?.toDouble() ?? 0.0,
      paid: (json['paid'] as num?)?.toDouble() ?? 0.0,
      closingBalance: (json['closingBalance'] as num?)?.toDouble() ?? 0.0,
      services: list
          .whereType<Map<String, dynamic>>()
          .map(HistoryService.fromJson)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'periodYear': periodYear,
    'periodMonth': periodMonth,
    'periodLabel': periodLabel,
    'openingBalance': openingBalance,
    'accrued': accrued,
    'paid': paid,
    'closingBalance': closingBalance,
    'services': services.map((e) => e.toJson()).toList(),
  };
}

class HistoryService {
  HistoryService({
    required this.name,
    required this.volume,
    required this.cubicMeters,
    required this.tariff,
    required this.amount,
    required this.tax,
    required this.total,
  });

  final String name;
  final int volume;
  final double cubicMeters;
  final double tariff;
  final double amount;
  final double tax;
  final double total;

  factory HistoryService.fromJson(Map<String, dynamic> json) {
    return HistoryService(
      name: json['name'] as String? ?? '',
      volume: json['volume'] as int? ?? 0,
      cubicMeters: (json['cubicMeters'] as num?)?.toDouble() ?? 0.0,
      tariff: (json['tariff'] as num?)?.toDouble() ?? 0.0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'volume': volume,
    'cubicMeters': cubicMeters,
    'tariff': tariff,
    'amount': amount,
    'tax': tax,
    'total': total,
  };
}
