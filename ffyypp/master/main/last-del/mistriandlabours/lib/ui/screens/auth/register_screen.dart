import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/enums/auth_type.dart';
import 'package:mistriandlabours/main.dart';
import 'package:mistriandlabours/models/app_roles.dart';
import 'package:mistriandlabours/services/auth_service.dart';
import 'package:mistriandlabours/services/firestorage_service.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
    this.authType = AuthType.user,
  }) : super(key: key);

  final AuthType authType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  String? _fname;
  String? _lname;
  String? _email;
  String? _password;
  bool _isLoading = false;

  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 5),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                    child: ClipOval(
                                        child: pickedImage != null
                                            ? Image.file(
                                                pickedImage!,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              )
                                            : IconButton(
                                                icon: Icon(
                                                  Icons.person,
                                                  color: Colors.grey.shade300,
                                                ),
                                                iconSize: 120,
                                                onPressed: imagePickerOption,
                                              )),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 5,
                                    child: IconButton(
                                      onPressed: imagePickerOption,
                                      icon: const Icon(
                                        Icons.add_a_photo_outlined,
                                        //  color: _primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        ContainerWithShadow(
                          child: TextFormField(
                            onChanged: (val) => _fname = val,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter First Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              hintText: 'Enter your first name',
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ContainerWithShadow(
                          child: TextFormField(
                            onChanged: (val) => _lname = val,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Last Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              hintText: 'Enter your last name',
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ContainerWithShadow(
                          child: TextFormField(
                            onChanged: (val) => _email = val,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              hintText: 'Enter your email address',
                            ),
                            keyboardType: TextInputType.emailAddress,
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
                        SizedBox(height: 20.0),
                        ContainerWithShadow(
                          child: TextFormField(
                            onChanged: (val) => _password = val,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                            ),
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ContainerWithShadow(
                          child: TextFormField(
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password*',
                              hintText: 'Enter your password again',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text(
                                      "I accept all terms and conditions.",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Container(
                          width: double.infinity,
                          child: PElevatedButton(
                            isBusy: _isLoading,
                            label: 'Register',
                            onPressed: () async => await _register(),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          "Or create account using social media",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 25.0),
                      ],
                    ),
                  ),
                ],
              ),
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

  void imagePickerOption() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Take Photo'),
              leading: Icon(Ionicons.camera_outline),
              onTap: () async {
                final _pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (_pickedImage != null) {
                  setState(() {
                    pickedImage = File(_pickedImage.path);
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Pick Photo'),
              leading: Icon(Ionicons.image_outline),
              onTap: () async {
                final _pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (_pickedImage != null) {
                  setState(() {
                    pickedImage = File(_pickedImage.path);
                  });
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              title: Text(
                'Close',
                style: TextStyle(color: AppColors.whiteColor),
              ),
              tileColor: AppColors.redColor,
              onTap: () {
                Navigator.pop(context);
              },
              trailing: Icon(
                Ionicons.close_outline,
                color: AppColors.whiteColor,
              ),
            )
          ],
        );
      },
    );
  }

  _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();

      try {
        setState(() {
          _isLoading = true;
        });
        final _name = '$_fname $_lname';
        final _role = widget.authType == AuthType.labour
            ? AppRoles.labour
            : AppRoles.user;

        String? _url;

        if (pickedImage != null) {
          _url = await context
              .read<FirestorageService>()
              .uploadFile(pickedImage!, DateTime.now().toIso8601String());
        }

        await context.read<BaseAuth>().signUpWithEmailAndPassword(
              _name,
              _role,
              _email!,
              _password!,
              _url,
            );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LandingScreen()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.redColor,
        ));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
