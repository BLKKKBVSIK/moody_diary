import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moody_diary/services/authentication_service.dart';
import 'package:moody_diary/ui/register/register_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../di/service_locator.dart';
import '../common/busy_text_button.dart';
import '../common/custom_scaffold.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterScreenViewModel>.reactive(
      viewModelBuilder: () => sl<RegisterScreenViewModel>(),
      builder: (context, viewModel, child) => CustomScaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 170),
                  child: Image.asset('assets/images/moody_diary_logo.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text('Register an account',
                  style: Theme.of(context).textTheme.headline1),
            ),
            Expanded(
              child: Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("*CONFIRM PASSWORD:",
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
                      controller: viewModel.confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      autocorrect: false,
                      obscureText: true,
                      style: const TextStyle(color: Colors.blue, fontSize: 16),
                      validator: (value) {
                        if (value != null && value.length >= 8) {
                          if (value != viewModel.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        } else {
                          return 'Password must be at least 8 characters';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text(
                        'All fields marked with * are required',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 11,
                            color: Colors.blue,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  BusyTextButton(
                      label: 'REGISTER',
                      isBusy: viewModel.isBusy,
                      onPressed: () async {
                        viewModel.register().then((value) {
                          if (sl<AuthenticationService>().isLogged) {
                            Navigator.pop(context);
                          }
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                        child: RichText(
                            text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'By creating an account, you agree to our ',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 9, color: Colors.blue),
                      ),
                      TextSpan(
                          text: 'Terms of Service',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(fontSize: 9, color: Colors.red),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              debugPrint('Tapped on Terms of Service');
                            }),
                    ]))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
