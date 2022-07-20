import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/enums/auth_type.dart';
import 'package:mistriandlabours/main.dart';
import 'package:mistriandlabours/services/auth_service.dart';
import 'package:mistriandlabours/ui/screens/auth/forgot_password_screen.dart';
import 'package:mistriandlabours/ui/screens/auth/register_screen.dart';
import 'package:mistriandlabours/widgets/buttons/p_text_button.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
    this.authType = AuthType.user,
  }) : super(key: key);
  final AuthType authType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;
  bool _isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 350,
                  child: HeaderWidget(
                    350,
                    true,
                    Icons.login_rounded,
                  ), //let's create a common header widget
                ),
                Positioned.fill(
                  left: 20,
                  right: 20,
                  top: 50,
                  child: Center(
                    child: Container(
                      height: 250,
                      width: 250,
                      child: Image(image: AssetImage("asset/images/mh.png")),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: BackButton(color: AppColors.whiteColor),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ), // This will be the login form
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.authType == AuthType.labour ? 'Labour' : 'User',
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                    ),
                    Text(
                      'Sign in into your account',
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.greyColor,
                          ),
                    ),
                    SizedBox(height: 30.0),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ContainerWithShadow(
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (val) => _email = val,
                                decoration: InputDecoration(
                                  labelText: 'Email address',
                                  hintText: 'Enter your email address',
                                ),
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Email';
                                  } else if (!value.contains('@')) {
                                    return 'Please Enter Valid Email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 30.0),
                            ContainerWithShadow(
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                onChanged: (val) => _password = val,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                ),
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: PTextButton(
                                label: "Forgot your password?",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: PElevatedButton(
                                isBusy: _isLoading,
                                onPressed: () async => await _signIn(),
                                label: 'Sign in',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Text.rich(TextSpan(children: [
                                TextSpan(text: "Don\'t have an account? "),
                                TextSpan(
                                  text: 'Create',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen(
                                                  authType: widget.authType,
                                                )),
                                      );
                                    },
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ])),
                            ),
                          ],
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        _isLoading = true;
        setState(() {});
        await context.read<BaseAuth>().signInWithEmailAndPassword(
              _email!,
              _password!,
            );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LandingScreen()));
      } on FirebaseAuthException catch (e) {
        final _snackBar = SnackBar(
          content: Text(e.message ?? e.toString()),
          backgroundColor: AppColors.redColor,
        );
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
