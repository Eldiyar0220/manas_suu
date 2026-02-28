// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceData _$DeviceDataFromJson(Map<String, dynamic> json) => DeviceData(
  deviceSystem: json['device_system'] as String,
  deviceId: json['device_id'] as String,
  deviceName: json['device_name'] as String,
  appVersion: json['app_version'] as String,
);

Map<String, dynamic> _$DeviceDataToJson(DeviceData instance) =>
    <String, dynamic>{
      'app_version': instance.appVersion,
      'device_id': instance.deviceId,
      'device_name': instance.deviceName,
      'device_system': instance.deviceSystem,
    };
