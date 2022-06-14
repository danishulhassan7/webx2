import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/labour.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class LabourProfileScreen extends StatelessWidget {
  const LabourProfileScreen({Key? key, required this.labour}) : super(key: key);
  final Labour labour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 100,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Container(
                    height: 120,
                    width: 120,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 0.1, color: Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: ClipOval(
                        child: labour.photoUrl != null
                            ? CachedNetworkImage(
                                imageUrl: labour.photoUrl!,
                                fit: BoxFit.cover,
                              )
                            : IconButton(
                                icon: Icon(
                                  Ionicons.person_outline,
                                  color: Colors.grey.shade300,
                                ),
                                iconSize: 60,
                                onPressed: () {},
                              )),
                  ),
                  SizedBox(height: 10),
                  Text(
                    labour.displayName ?? '',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    labour.location ?? '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Labour Information",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                horizontalTitleGap: 0,
                                isThreeLine: true,
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Ionicons.location_outline),
                                title: Text("Location"),
                                subtitle: Text(labour.location ?? 'N/A'),
                              ),
                              ListTile(
                                isThreeLine: true,
                                horizontalTitleGap: 0,
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Ionicons.phone_portrait_outline),
                                title: Text("Phone"),
                                subtitle: Text(labour.phoneNumber ?? 'N/A'),
                              ),
                              ListTile(
                                isThreeLine: true,
                                horizontalTitleGap: 0,
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Ionicons.person_outline),
                                title: Text("Number of team members"),
                                subtitle: Text(labour.member ?? 'N/A'),
                              ),
                              ListTile(
                                isThreeLine: true,
                                horizontalTitleGap: 0,
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Ionicons.information_outline),
                                title: Text("About"),
                                subtitle: Text(labour.about ?? ''),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                child: PElevatedButton(
                                  label: 'Hire Labour',
                                  iconOnLeading: true,
                                  icon: Icon(Ionicons.call_outline),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Congratulations"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Now you can contact this Number",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  String url = Platform.isIOS
                                                      ? 'tel://${labour.phoneNumber}'
                                                      : 'tel:${labour.phoneNumber}';
                                                  if (await canLaunchUrl(
                                                      Uri.parse(url))) {
                                                    await launchUrl(
                                                        Uri.parse(url));
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                child: Text(
                                                  "${labour.phoneNumber}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
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
}
