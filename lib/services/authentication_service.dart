import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class AuthenticationService with ReactiveServiceMixin {
  AuthenticationService() {
    listenToReactiveValues([_user]);
    listenToReactiveValues([_isLogged]);
  }

  final RxValue<String?> _authException = RxValue<String?>(null);
  String? get authException => _authException.value;

  final RxValue<bool> _isLogged = RxValue<bool>(false);
  bool get isLogged => _isLogged.value;

  final RxValue<User?> _user = RxValue<User?>(null);
  User? get user => _user.value;

  final RxValue<String> _sessionId = RxValue<String>('');

  Client client = Client(
    endPoint: 'http://' + (dotenv.env['APPWRITE_ENDPOINT']!) + '/v1',
  ).setProject(dotenv.env['APPWRITE_PROJECT_ID']);

  // Login with email and password.
  Future loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      Account account = Account(client);

      Session result = await account.createSession(
        email: email,
        password: password,
      );

      _sessionId.value = result.$id;
      await getCurrentUser();
    } catch (e) {
      setAuthException(text: e.toString());
      debugPrint(e.toString());
    }
  }

  // Logs out the user.
  Future logout() async {
    try {
      Account account = Account(client);
      User result = await account.deleteSession(sessionId: _sessionId.value);
      _isLogged.value = false;
      _user.value = null;
      notifyListeners();
    } catch (e) {
      setAuthException(text: e.toString());
      debugPrint(e.toString());
    }
  }

  // Register a new user.
  Future<dynamic> registerNewUser({
    required String email,
    required String password,
  }) async {
    await createNewAccount(email, password);
    await loginWithEmail(email: email, password: password);
  }

  Future<User?> createNewAccount(String email, String password) async {
    try {
      Account account = Account(client);

      User result = await account.create(
        userId: 'unique()',
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      setAuthException(text: e.toString());
      debugPrint(e.toString());
      return null;
    }
  }

  Future getCurrentUser() async {
    try {
      Account account = Account(client);
      User result = await account.get();

      _user.value = result;
      _isLogged.value = true;
      notifyListeners();
    } catch (e) {
      setAuthException(text: e.toString());
      debugPrint(e.toString());
    }
  }

  void setAuthException({required text}) {
    _authException.value = text;
    notifyListeners();
  }

  displaySnackbarError(BuildContext context, String displayedError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text(displayedError, style: const TextStyle(color: Colors.red))),
    );
  }
}
