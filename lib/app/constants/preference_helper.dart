import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class PreferenceHelper {
  static const String save = 'save';
  static const String accessToken = 'accessToken';
  static const String personalAccount = 'personalAccount';
  static const String deviceId = 'deviceId';
  static const String messageToken = 'fcmToken';
  SharedPreferences? _preferences;
  SharedPreferences? get preferences => _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    await init();
    if (_preferences != null) {
      _preferences!.clear();
    }
  }

  Future<String?> getOrCreateDeviceId() async {
    if (_preferences == null) {
      await init();
    }
    final prefs = _preferences;
    if (prefs == null) {
      return await _readDeviceIdFromPlatform();
    }
    final cached = prefs.getString(deviceId);
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }
    final platformId = await _readDeviceIdFromPlatform();
    if (platformId == null || platformId.isEmpty) {
      return null;
    }
    await prefs.setString(deviceId, platformId);
    return platformId;
  }

  Future<String?> _readDeviceIdFromPlatform() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return info.id;
    }
    if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return info.identifierForVendor;
    }
    if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      return info.systemGUID;
    }
    if (Platform.isWindows) {
      final info = await deviceInfo.windowsInfo;
      return info.deviceId;
    }
    if (Platform.isLinux) {
      final info = await deviceInfo.linuxInfo;
      return info.machineId;
    }
    return null;
  }
}
