import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/services/auth_service.dart';
import 'package:mistriandlabours/ui/screens/auth/login_screen.dart';
import 'package:mistriandlabours/widgets/buttons/p_elevated_button.dart';
import 'package:mistriandlabours/widgets/common/container_with_shadow.dart';
import 'package:mistriandlabours/widgets/design/header_widget.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _email;
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: _headerHeight,
                  child:
                      HeaderWidget(_headerHeight, true, Icons.password_rounded),
                ),
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Enter the email address associated with your account.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'We will email you a verification code to check your authenticity.',
                                style: TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              ContainerWithShadow(
                                child: TextFormField(
                                  controller: _emailController,
                                  onChanged: (val) => _email = val,
                                  decoration: InputDecoration(
                                    labelText: 'Email Address',
                                    hintText: 'Enter your email address',
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Email can't be empty";
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(val)) {
                                      return "Enter a valid email address";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                width: double.infinity,
                                child: PElevatedButton(
                                  isBusy: _isLoading,
                                  label: 'Send Email',
                                  onPressed: () async => _resetPassword(),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Remember your password? "),
                                    TextSpan(
                                      text: 'Login',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        },
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: 40,
              left: 10,
              child: BackButton(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }

  _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });
        await context.read<BaseAuth>().sendPasswordResetEmail(_email!);
        final _snackbar = SnackBar(
          content: Text('Password reset email sent'),
          backgroundColor: AppColors.greenColor,
        );
        _emailController.clear();
        ScaffoldMessenger.of(context).showSnackBar(_snackbar);
      } on FirebaseAuthException catch (e) {
        final _snackbar = SnackBar(
          content: Text(e.message ?? e.toString()),
          backgroundColor: AppColors.redColor,
        );
        ScaffoldMessenger.of(context).showSnackBar(_snackbar);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
