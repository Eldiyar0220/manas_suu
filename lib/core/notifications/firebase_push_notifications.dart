import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/app/constants/preference_helper.dart';

@injectable
class FirebasePushNotifications {
  final _firebaseMessage = FirebaseMessaging.instance;
  final _pref = GetIt.I<PreferenceHelper>().preferences;

  Future<String?> getToken() async {
    try {
      if (Platform.isIOS) {
        await _firebaseMessage.requestPermission(
          sound: true,
          badge: true,
          alert: true,
        );
      }
      final token = await _firebaseMessage.getToken();
      if (token != null) {
        await _pref?.setString(PreferenceHelper.messageToken, token);
      }
      return token;
    } catch (e) {
      return _pref?.getString(PreferenceHelper.messageToken) ?? '';
    }
  }

  Future<void> initialPushNotifications(
    Function(RemoteMessage message, bool showDialog) onPushMessage,
  ) async {
    if (Platform.isIOS) {
      await _firebaseMessage.requestPermission();
    }
    late String? pushId;
    _firebaseMessage.getInitialMessage().then((msg) {
      if (msg != null) {
        ///TODO soon надо поговорить с бэком
        // pushId = GetPushModel.fromJson(msg.data).pushId;
        // if (pushId != null) {
        // GetIt.I<PushNotificationBloc>().add(
        //   OpenPushNotificationEvent(
        //     pushId: pushId!,
        //   ),
        // );
        // }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        onPushMessage(message, true);
      }
    });
  }
}
