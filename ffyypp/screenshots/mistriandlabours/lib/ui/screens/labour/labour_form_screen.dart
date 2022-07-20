import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/config/theme_helper.dart';
import 'package:mistriandlabours/models/labour.dart';
import 'package:mistriandlabours/services/firestorage_service.dart';
import 'package:mistriandlabours/services/labour_service.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';
import 'package:provider/provider.dart';

class LabourFormScreen extends StatefulWidget {
  const LabourFormScreen({
    Key? key,
    this.viewOnly = false,
    this.labour,
  }) : super(key: key);

  final bool viewOnly;
  final Labour? labour;

  @override
  State<LabourFormScreen> createState() => _LabourFormScreenState();
}

class _LabourFormScreenState extends State<LabourFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _phone;
  String? _location;
  String? _member;
  String? _name;
  String? _about;
  File? _pickedFile;
  bool _isLoading = false;

  @override
  void initState() {
    _phone = widget.labour?.phoneNumber;
    _location = widget.labour?.location;
    _member = widget.labour?.member;
    _name = widget.labour?.displayName;
    _about = widget.labour?.about;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color _primaryColor = AppColors.primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 50),
                            Align(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Positioned(
                                      child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _primaryColor,
                                        width: 5,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                    child: ClipOval(
                                        child: _pickedFile != null
                                            ? Image.file(
                                                _pickedFile!,
                                                fit: BoxFit.cover,
                                              )
                                            : widget.labour?.photoUrl != null
                                                ? CachedNetworkImage(
                                                    imageUrl: widget
                                                        .labour!.photoUrl!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : IconButton(
                                                    icon: Icon(
                                                      Ionicons.person_outline,
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                    iconSize: 60,
                                                    onPressed: () {},
                                                  )),
                                  )),
                                  if (!widget.viewOnly)
                                    Positioned(
                                      bottom: 0,
                                      right: 5,
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: _primaryColor,
                                        child: IconButton(
                                          onPressed: imagePickerOption,
                                          icon: Icon(
                                            Ionicons.add_outline,
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
                            initialValue: widget.labour?.displayName,
                            enabled: !widget.viewOnly,
                            onChanged: (val) => _name = val,
                            textInputAction: TextInputAction.next,
                            validator: (val) => (val?.isEmpty ?? false)
                                ? 'Please enter name'
                                : null,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: 'Enter your name',
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20),
                        ContainerWithShadow(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            initialValue: widget.labour?.phoneNumber,
                            enabled: !widget.viewOnly,
                            onChanged: (val) => _phone = val,
                            validator: (val) => (val?.isEmpty ?? false)
                                ? 'Please enter phone number'
                                : null,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: 'Enter your phone number',
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ContainerWithShadow(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            initialValue: widget.labour?.location,
                            enabled: !widget.viewOnly,
                            onChanged: (val) => _location = val,
                            decoration: InputDecoration(
                              labelText: 'Location',
                              hintText: 'Enter your location',
                            ),
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
                            textInputAction: TextInputAction.next,
                            initialValue: widget.labour?.member,
                            enabled: !widget.viewOnly,
                            onChanged: (val) => _member = val,
                            decoration: InputDecoration(
                              labelText: 'Member',
                              hintText: 'Enter your member',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter your member';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ContainerWithShadow(
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            onChanged: (val) => _about = val,
                            initialValue: widget.labour?.about,
                            enabled: !widget.viewOnly,
                            maxLines: 3,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
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
                        if (!widget.viewOnly)
                          Container(
                            width: double.infinity,
                            child: PElevatedButton(
                              isBusy: _isLoading,
                              label: 'Update Profile',
                              onPressed: () async => await _submit(),
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
                    _pickedFile = File(_pickedImage.path);
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
                    _pickedFile = File(_pickedImage.path);
                  });
                }
                Navigator.pop(context);
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

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });

        final _id = widget.labour?.id ?? DateTime.now().toString();

        String? _url;

        if (_pickedFile != null) {
          _url = await context
              .read<FirestorageService>()
              .uploadFile(_pickedFile!, _id);
        } else {
          _url = widget.labour?.photoUrl;
        }

        final _labour = Labour(
          id: _id,
          displayName: _name,
          phoneNumber: _phone,
          location: _location,
          member: _member,
          about: _about,
          rating: widget.labour?.rating ?? 0,
          email: widget.labour?.email,
          photoUrl: _url,
        );

        await context.read<LabourService>().setLabour(_labour);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
