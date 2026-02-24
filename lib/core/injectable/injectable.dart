import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/app/constants/preference_helper.dart';
import 'package:manas_suu_app/core/injectable/injectable.config.dart';
import 'package:manas_suu_app/firebase_options.dart';

final getIt = GetIt.instance;
final globalKey = GlobalKey<ScaffoldMessengerState>();

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureDependencies({String? environment}) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  $initGetIt(getIt, environment: environment);

  await EasyLocalization.ensureInitialized();
  await getIt<PreferenceHelper>().init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

abstract class AppEnv {
  static const dev = Environment.dev;
  static const prod = Environment.prod;
}

class ProvidersWrapper extends StatelessWidget {
  const ProvidersWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [], child: child);
  }
}
