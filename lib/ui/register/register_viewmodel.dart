import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import '../../services/authentication_service.dart';

@injectable
class RegisterScreenViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;

  RegisterScreenViewModel(this._authenticationService);

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> register() async {
    setBusy(true);
    notifyListeners();
    await _authenticationService.registerNewUser(
        email: _emailController.text, password: _passwordController.text);
    setBusy(false);
    notifyListeners();
  }

  String get email => _emailController.text;
  String get password => _passwordController.text;

  void setEmail(String email) {
    _emailController.text = email;
  }

  void setPassword(String password) {
    _passwordController.text = password;
  }
}
