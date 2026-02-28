// ignore_for_file: avoid_classes_with_only_static_members, deprecated_member_use

import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:manas_suu_app/core/dio_settings/device_data/device_data.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

class DeviceDataHelper {
  static Future<DeviceData> get deviceData async {
    var system = '';
    var name = '';
    var id = '';

    if (Platform.isIOS) {
      final deviceInfo = await DeviceInfoPlugin().iosInfo;
      system = '${deviceInfo.systemName}, ${deviceInfo.systemVersion}';
      name = deviceInfo.model;
      id = deviceInfo.identifierForVendor ?? Uuid.NAMESPACE_X500;
    } else if (Platform.isAndroid) {
      const deviceId = AndroidId();
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      system = 'Android ${deviceInfo.version.release}';
      name = '${deviceInfo.brand} ${deviceInfo.model}';
      id = await deviceId.getId() ?? '';
    }
    final packageInfo = await PackageInfo.fromPlatform();

    return DeviceData(
      deviceSystem: system,
      deviceId: id,
      deviceName: name,
      appVersion: packageInfo.version,
    );
  }
}
