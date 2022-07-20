import 'package:flutter/material.dart';
import 'package:mistriandlabours/enums/auth_type.dart';
import 'package:mistriandlabours/ui/screens/auth/login_screen.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';

class LoginOptionsScreen extends StatelessWidget {
  const LoginOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PElevatedButton(
                    label: 'Login for labour'.toUpperCase(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(
                            authType: AuthType.labour,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  PElevatedButton(
                    label: 'Login for user'.toUpperCase(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(
                            authType: AuthType.user,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
