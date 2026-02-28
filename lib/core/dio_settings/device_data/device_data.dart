import 'package:json_annotation/json_annotation.dart';

part 'device_data.g.dart';

@JsonSerializable()
class DeviceData {
  DeviceData({
    required this.deviceSystem,
    required this.deviceId,
    required this.deviceName,
    required this.appVersion,
  });

  factory DeviceData.fromJson(Map<String, dynamic> json) =>
      _$DeviceDataFromJson(json);

  @JsonKey(name: 'app_version')
  final String appVersion;

  @JsonKey(name: 'device_id')
  final String deviceId;

  @JsonKey(name: 'device_name')
  final String deviceName;

  @JsonKey(name: 'device_system')
  final String deviceSystem;

  Map<String, dynamic> toJson() => _$DeviceDataToJson(this);

  Map<String, dynamic> toCamelCaseJson() => {
    'deviceSystem': deviceSystem,
    'deviceId': deviceId,
    'deviceName': deviceName,
    'appVersion': appVersion,
  };
}
