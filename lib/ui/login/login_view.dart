import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../di/service_locator.dart';
import '../common/busy_text_button.dart';
import '../common/custom_scaffold.dart';
import '../register/register_view.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginScreenViewModel>.reactive(
      viewModelBuilder: () => sl<LoginScreenViewModel>(),
      builder: (context, viewModel, child) => CustomScaffold(
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 170),
                child: Image.asset('assets/images/moody_diary_logo.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Text('Already have an account?',
                style: Theme.of(context).textTheme.headline1),
          ),
          Expanded(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("*E-MAIL :",
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.start),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                      ),
                      controller: viewModel.emailController,
                      textInputAction: TextInputAction.done,
                      autocorrect: false,
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.blue, fontSize: 16),
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(pattern);

                        return regExp.hasMatch(value ?? '')
                            ? null
                            : 'Please enter a valid email address';
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("*PASSWORD :",
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.start),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                      ),
                      controller: viewModel.passwordController,
                      textInputAction: TextInputAction.done,
                      autocorrect: false,
                      obscureText: true,
                      style: const TextStyle(color: Colors.blue, fontSize: 16),
                      validator: (value) {
                        if (value != null && value.length >= 8) return null;

                        return 'Password must be at least 8 characters';
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: BusyTextButton(
                      label: 'LOGIN',
                      isBusy: viewModel.isBusy,
                      onPressed: viewModel.loginWithEmail,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 15, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: (() => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const RegisterScreen()))),
                        child: Text(
                          ' Register',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple.shade200),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
