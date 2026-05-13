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
    this.personalAccount,
    this.fullName,
    this.address,
    this.periods,
  });

  final String? personalAccount;
  final String? fullName;
  final String? address;
  final List<HistoryModel>? periods;

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    final rawPeriods = json['periods'];
    List<HistoryModel>? periods;
    if (rawPeriods == null) {
      periods = null;
    } else if (rawPeriods is List) {
      periods = rawPeriods
          .whereType<Map<String, dynamic>>()
          .map(HistoryModel.fromJson)
          .toList();
    } else {
      periods = null;
    }

    return HistoryData(
      personalAccount: json['personalAccount'] as String?,
      fullName: json['fullName'] as String?,
      address: json['address'] as String?,
      periods: periods,
    );
  }

  Map<String, dynamic> toJson() => {
    'personalAccount': personalAccount,
    'fullName': fullName,
    'address': address,
    'periods': periods?.map((e) => e.toJson()).toList(),
  };
}

class HistoryModel {
  HistoryModel({
    this.periodYear,
    this.periodMonth,
    this.periodLabel,
    this.openingBalance,
    this.accrued,
    this.paid,
    this.closingBalance,
    this.services,
  });

  final int? periodYear;
  final int? periodMonth;
  final String? periodLabel;
  final double? openingBalance;
  final double? accrued;
  final double? paid;
  final double? closingBalance;
  final List<HistoryService>? services;

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    final rawServices = json['services'];
    List<HistoryService>? services;
    if (rawServices == null) {
      services = null;
    } else if (rawServices is List) {
      services = rawServices
          .whereType<Map<String, dynamic>>()
          .map(HistoryService.fromJson)
          .toList();
    } else {
      services = null;
    }

    return HistoryModel(
      periodYear: json['periodYear'] as int?,
      periodMonth: json['periodMonth'] as int?,
      periodLabel: json['periodLabel'] as String?,
      openingBalance: (json['openingBalance'] as num?)?.toDouble(),
      accrued: (json['accrued'] as num?)?.toDouble(),
      paid: (json['paid'] as num?)?.toDouble(),
      closingBalance: (json['closingBalance'] as num?)?.toDouble(),
      services: services,
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
    'services': services?.map((e) => e.toJson()).toList(),
  };
}

class HistoryService {
  HistoryService({
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

  factory HistoryService.fromJson(Map<String, dynamic> json) {
    return HistoryService(
      name: json['name'] as String?,
      volume: (json['volume'] as num?)?.toInt(),
      cubicMeters: (json['cubicMeters'] as num?)?.toDouble(),
      tariff: (json['tariff'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
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
