import 'package:json_annotation/json_annotation.dart';

part 'notifications_model.g.dart';

class NotificationsResponse {
  NotificationsResponse({required this.status, required this.data});

  final String status;
  final List<NotificationsModel> data;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final list = rawData is List ? rawData : const [];

    return NotificationsResponse(
      status: json['status'] as String? ?? '',
      data: list
          .whereType<Map<String, dynamic>>()
          .map(NotificationsModel.fromJson)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

@JsonSerializable()
class NotificationsModel {
  final int id;
  final String title;
  final String body;
  final bool isRead;
  final String creationDate;

  NotificationsModel({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.creationDate,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsModelToJson(this);

  NotificationsModel copyWith({
    int? id,
    String? title,
    String? body,
    bool? isRead,
    String? creationDate,
  }) {
    return NotificationsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
