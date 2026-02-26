// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../app/constants/preference_helper.dart' as _i692;
import '../../feature/contacts/data/repository/contacts_repository_impl.dart'
    as _i773;
import '../../feature/contacts/domain/interactor/contacts_interactor.dart'
    as _i459;
import '../../feature/contacts/domain/repository/contacts_repository.dart'
    as _i384;
import '../../feature/main/data/repository/main_repository_impl.dart' as _i268;
import '../../feature/main/domain/interactor/main_interactor.dart' as _i332;
import '../../feature/main/domain/repository/main_repository.dart' as _i234;
import '../../feature/main/presentation/bloc/main_cubit.dart' as _i503;
import '../../feature/settings/data/repository/settings_repository_impl.dart'
    as _i993;
import '../../feature/settings/domain/interactor/settings_interactor.dart'
    as _i774;
import '../../feature/settings/domain/repository/settings_repository.dart'
    as _i103;
import '../../feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart'
    as _i778;
import '../../feature/splash/data/repository/splash_repository_impl.dart'
    as _i228;
import '../../feature/splash/domain/interactor/splash_interactor.dart' as _i111;
import '../../feature/splash/domain/repository/splash_repository.dart' as _i467;
import '../../feature/splash/presentation/bloc/splash_bloc.dart' as _i813;
import '../dio_settings/dio_settings.dart' as _i351;
import '../notifications/local_notifications_service.dart' as _i111;

const String _dev = 'dev';
const String _prod = 'prod';

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i692.PreferenceHelper>(() => _i692.PreferenceHelper());
  gh.singleton<_i111.LocalNotificationsService>(
    () => _i111.LocalNotificationsService(),
  );
  gh.factory<String>(
    () => registerModule.devBaseUrl,
    instanceName: 'BaseUrl',
    registerFor: {_dev},
  );
  gh.singleton<_i778.ThemeInteractor>(
    () => _i778.ThemeInteractor(gh<_i692.PreferenceHelper>()),
  );
  gh.factory<String>(
    () => registerModule.prodBaseUrl,
    instanceName: 'BaseUrl',
    registerFor: {_prod},
  );
  gh.singleton<_i778.ThemeCubit>(
    () => _i778.ThemeCubit(gh<_i778.ThemeInteractor>()),
  );
  gh.lazySingleton<_i361.Dio>(
    () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')),
  );
  gh.factory<_i234.MainRepository>(
    () => _i268.MainRepositoryImpl(gh<_i361.Dio>()),
  );
  gh.singleton<_i384.ContactsRepository>(
    () => _i773.ContactsRepositoryImpl(gh<_i361.Dio>()),
  );
  gh.singleton<_i103.SettingsRepository>(
    () => _i993.SettingsRepositoryImpl(gh<_i361.Dio>()),
  );
  gh.singleton<_i467.SplashRepository>(
    () => _i228.SplashRepositoryImpl(gh<_i361.Dio>()),
  );
  gh.factory<_i332.MainInteractor>(
    () => _i332.MainInteractor(
      gh<_i234.MainRepository>(),
      gh<_i692.PreferenceHelper>(),
    ),
  );
  gh.singleton<_i503.MainCubit>(
    () => _i503.MainCubit(gh<_i332.MainInteractor>()),
  );
  gh.singleton<_i459.ContactsInteractor>(
    () => _i459.ContactsInteractor(gh<_i384.ContactsRepository>()),
  );
  gh.singleton<_i111.SplashInteractor>(
    () => _i111.SplashInteractor(gh<_i467.SplashRepository>()),
  );
  gh.singleton<_i774.SettingsInteractor>(
    () => _i774.SettingsInteractor(gh<_i103.SettingsRepository>()),
  );
  gh.factory<_i813.SplashBloc>(
    () => _i813.SplashBloc(gh<_i111.SplashInteractor>()),
  );
  return getIt;
}

class _$RegisterModule extends _i351.RegisterModule {}
