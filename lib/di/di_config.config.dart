// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/services/api_services.dart' as _i3;
import '../domain/repo/auth_repo.dart' as _i5;
import '../domain/repo/i_auth_repo.dart' as _i4;
import '../domain/repo/i_user_repo.dart' as _i7;
import '../domain/repo/mock_auth_repo.dart' as _i6;
import '../domain/repo/mock_user_repo.dart' as _i8;
import '../domain/repo/user_repo.dart' as _i9;
import '../domain/usecase/app_state_usecase.dart' as _i11;
import '../domain/usecase/create_account_usecase.dart' as _i12;
import '../domain/usecase/login_screen_usecase.dart' as _i10;

const String _DEVELOPMENT = 'DEVELOPMENT';
const String _PRODUCTION = 'PRODUCTION';
const String _TESTING = 'TESTING';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.ApiServices>(_i3.ApiServices());
  gh.factory<_i4.IAuthRepo>(
    () => _i5.AuthRepo(),
    registerFor: {
      _DEVELOPMENT,
      _PRODUCTION,
    },
  );
  gh.factory<_i4.IAuthRepo>(
    () => _i6.MockAuthRepo(),
    registerFor: {_TESTING},
  );
  gh.factory<_i7.IUserRepo>(
    () => _i8.MockUserRepo(),
    registerFor: {_TESTING},
  );
  gh.factory<_i7.IUserRepo>(
    () => _i9.UserRepo(),
    registerFor: {
      _DEVELOPMENT,
      _PRODUCTION,
    },
  );
  gh.factory<_i10.LoginScreenUseCase>(
    () => _i10.LoginScreenUseCase(get<_i4.IAuthRepo>()),
    registerFor: {
      _DEVELOPMENT,
      _PRODUCTION,
      _TESTING,
    },
  );
  gh.factory<_i11.AppStateUseCase>(
    () => _i11.AppStateUseCase(
      get<_i4.IAuthRepo>(),
      get<_i7.IUserRepo>(),
    ),
    registerFor: {
      _DEVELOPMENT,
      _PRODUCTION,
      _TESTING,
    },
  );
  gh.factory<_i12.CreateAccountUseCase>(
    () => _i12.CreateAccountUseCase(
      get<_i4.IAuthRepo>(),
      get<_i7.IUserRepo>(),
    ),
    registerFor: {
      _DEVELOPMENT,
      _PRODUCTION,
      _TESTING,
    },
  );
  return get;
}
