import 'package:flutter/material.dart';
import 'package:moody_diary/ui/common/busy_text_button.dart';
import 'package:moody_diary/ui/common/custom_scaffold.dart';

import '../../di/service_locator.dart';
import '../../services/authentication_service.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("You're logged !",
                style: Theme.of(context).textTheme.headline1),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    sl<AuthenticationService>().user != null
                        ? (sl<AuthenticationService>().user!).email
                        : 'N/A',
                    style: Theme.of(context).textTheme.headline1),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BusyTextButton(
                    label: "Log out",
                    onPressed: () {
                      sl<AuthenticationService>().logout();
                    },
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
