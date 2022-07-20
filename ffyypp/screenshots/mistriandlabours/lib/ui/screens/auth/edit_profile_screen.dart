import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/config/theme_helper.dart';
import 'package:mistriandlabours/models/app_user.dart';
import 'package:mistriandlabours/services/auth_service.dart';
import 'package:mistriandlabours/services/firestorage_service.dart';
import 'package:mistriandlabours/services/user_service.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  String? phone;
  String? location;
  String? member;
  String? name;
  String? about;
  bool _isLoading = false;
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final phoneController = TextEditingController();
  final locationCotrolletr = TextEditingController();
  final memberController = TextEditingController();
  final nameController = TextEditingController();
  final aboutController = TextEditingController();

  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    Color _primaryColor = AppColors.primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<AppUser>(
          stream: context
              .read<UserService>()
              .getUser(context.read<BaseAuth>().userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final AppUser user = snapshot.data!;
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      child: HeaderWidget(
                        150,
                        false,
                        Icons.person_add_alt_1_rounded,
                      ),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: _primaryColor,
                                                width: 5,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(100),
                                              ),
                                            ),
                                            child: ClipOval(
                                              child: pickedImage != null
                                                  ? Image.file(
                                                      pickedImage!,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : user.photoUrl != null
                                                      ? CachedNetworkImage(
                                                          imageUrl:
                                                              user.photoUrl!,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : IconButton(
                                                          icon: Icon(
                                                            Icons.person,
                                                            color: Colors
                                                                .grey.shade300,
                                                          ),
                                                          iconSize: 120,
                                                          onPressed: () {},
                                                        ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 5,
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: _primaryColor,
                                              child: IconButton(
                                                onPressed: imagePickerOption,
                                                icon: Icon(
                                                  Icons.add_outlined,
                                                  size: 26,
                                                  color: AppColors.whiteColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  child: TextFormField(
                                    initialValue: user.displayName,
                                    onChanged: (val) => name = val,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      hintText: 'Enter your name',
                                    ),
                                  ),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 30),
                                ContainerWithShadow(
                                  child: TextFormField(
                                    onChanged: (val) => phone = val,
                                    initialValue: user.phoneNumber,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      hintText: 'Enter your phone number',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter your phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                ContainerWithShadow(
                                  child: TextFormField(
                                    onChanged: (val) => location = val,
                                    initialValue: user.location,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Location',
                                      hintText: 'Enter your location',
                                    ),
                                    // decoration: ThemeHelper().textInputDecoration(
                                    //     "Location", "Enter your Location"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Location';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                ContainerWithShadow(
                                  child: TextFormField(
                                    onChanged: (val) => about = val,
                                    initialValue: user.about,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      labelText: 'About',
                                      hintText: 'Enter your about',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter your about';
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
                                    label: 'Update Profile',
                                    onPressed: () async =>
                                        await _updateProfile(user),
                                  ),
                                ),
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
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
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

  _updateProfile(AppUser appUser) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      try {
        setState(() {
          _isLoading = true;
        });

        AppUser _user = appUser.copyWith(
          name: name,
          phoneNumber: phone,
          location: location,
          about: about,
        );

        if (pickedImage != null) {
          final _url = await context
              .read<FirestorageService>()
              .uploadFile(pickedImage!, appUser.id);
          _user = _user.copyWith(
            photoUrl: _url,
          );
        }

        await context.read<BaseAuth>().updateUser(_user);
        Navigator.pop(context);
      } catch (e) {
        print(e);
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
