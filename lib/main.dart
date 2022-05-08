import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:moody_diary/misc/theme.dart';
import 'package:moody_diary/services/authentication_service.dart';
import 'package:moody_diary/ui/homepage/homepage_view.dart';
import 'package:moody_diary/ui/login/login_view.dart';
import 'package:stacked/stacked.dart';

import 'di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyInjection();
  await dotenv.load(fileName: ".env");
  runApp(const MoodyDiaryApp());
}

class MoodyDiaryApp extends StatelessWidget {
  const MoodyDiaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: kDebugMode,
        title: 'Liv-n',
        theme: livnTheme,
        home: const LoginWrapper());
  }
}

class LoginWrapper extends StatelessWidget {
  const LoginWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginWrapperViewModel>.reactive(
      onModelReady: (viewModel) async => await viewModel.init(),
      viewModelBuilder: () => sl<LoginWrapperViewModel>(),
      builder: (context, viewModel, child) =>
          viewModel.isLogged ? const HomepageScreen() : const LoginScreen(),
    );
  }
}

@injectable
class LoginWrapperViewModel extends ReactiveViewModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authenticationService];

  bool get isLogged => _authenticationService.isLogged;

  init() async {
    await _authenticationService.getCurrentUser();
  }
}
