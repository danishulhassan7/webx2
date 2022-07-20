import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/app_user.dart';
import 'package:mistriandlabours/services/auth_service.dart';
import 'package:mistriandlabours/ui/screens/auth/edit_profile_screen.dart';
import 'package:mistriandlabours/ui/screens/labour/labour_form_screen.dart';
import 'package:mistriandlabours/ui/screens/labour/labours_screen.dart';
import 'package:mistriandlabours/ui/screens/user/job_form_screen.dart';
import 'package:mistriandlabours/ui/screens/user/jobs_screen.dart';
import 'package:mistriandlabours/ui/screens/user/my_orders_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<AppUser>(
        builder: (context, user, _) {
          return Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    child: user.photoUrl == null
                        ? Icon(Ionicons.camera_outline)
                        : CachedNetworkImage(
                            height: 100,
                            width: 100,
                            imageUrl: user.photoUrl!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                accountName: Text(user.displayName ?? ''),
                accountEmail: Text(
                    (user.role == 'user' ? user.phoneNumber : user.email) ??
                        ''),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                ),
              ),
              if (user.role == 'user')
                ListTile(
                  leading: Icon(Ionicons.person_add_outline),
                  title: Text('Post a Job'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => JobFormScreen()),
                    );
                  },
                ),
              if (user.role == 'user')
                ListTile(
                  leading: Icon(Ionicons.folder_outline),
                  title: Text('All Jobs'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => JobsScreen()),
                    );
                  },
                ),
              if (user.role == 'user')
                ListTile(
                  leading: Icon(Ionicons.ticket_outline),
                  title: Text('My Orders'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Provider.value(
                          value: user,
                          child: MyOrdersScreen(),
                        ),
                      ),
                    );
                  },
                ),
              if (user.role == 'labour')
                ListTile(
                  leading: Icon(Ionicons.person_add_outline),
                  title: Text('Add member'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LabourFormScreen()),
                    );
                  },
                ),
              if (user.role == 'labour')
                ListTile(
                  leading: Icon(Ionicons.school_outline),
                  title: Text('All members'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LaboursScreen()),
                    );
                  },
                ),
              ListTile(
                leading: Icon(Ionicons.person_outline),
                title: Text('Edit your profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditProfileScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Ionicons.log_out_outline),
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text('Do you want to logout?'),
                        actions: [
                          TextButton(
                            child: Text('No'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async {
                              await context.read<BaseAuth>().signOut();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
