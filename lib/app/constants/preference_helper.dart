import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class PreferenceHelper {
  static const String save = 'save';
  static const String accessToken = 'accessToken';
  static const String personalAccount = 'personalAccount';
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
}
