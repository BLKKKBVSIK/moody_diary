import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import '../../services/authentication_service.dart';

@injectable
class LoginScreenViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;

  LoginScreenViewModel(this._authenticationService);

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  String get email => _emailController.text;
  String get password => _passwordController.text;

  void setEmail(String email) {
    _emailController.text = email;
  }

  void setPassword(String password) {
    _passwordController.text = password;
  }

  Future<void> loginWithEmail() async {
    setBusy(true);
    notifyListeners();
    await _authenticationService.loginWithEmail(
        email: email, password: password);
    setBusy(false);
    notifyListeners();
  }
}
