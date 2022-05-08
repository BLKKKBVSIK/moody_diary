// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i5;
import '../services/authentication_service.dart' as _i3;
import '../ui/login/login_viewmodel.dart' as _i4;
import '../ui/register/register_viewmodel.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthenticationService>(
      () => _i3.AuthenticationService());
  gh.factory<_i4.LoginScreenViewModel>(
      () => _i4.LoginScreenViewModel(get<_i3.AuthenticationService>()));
  gh.factory<_i5.LoginWrapperViewModel>(() => _i5.LoginWrapperViewModel());
  gh.factory<_i6.RegisterScreenViewModel>(
      () => _i6.RegisterScreenViewModel(get<_i3.AuthenticationService>()));
  return get;
}
