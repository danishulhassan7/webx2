import 'package:flutter/material.dart';
import 'package:mistriandlabours/models/app_user.dart';
import 'package:mistriandlabours/services/user_service.dart';
import 'package:mistriandlabours/ui/screens/labour/labour_home_screen.dart';
import 'package:mistriandlabours/ui/screens/user/user_home_screen.dart';
import 'package:provider/provider.dart';

class HomeSetupScreen extends StatelessWidget {
  final String userId;
  const HomeSetupScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser>(
        stream: context.read<UserService>().getUser(userId),
        builder: (context, snap) {
          if (snap.hasData) {
            return Provider<AppUser>.value(
              value: snap.data!,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: snap.data!.role == 'user'
                    ? UserHomeScreen()
                    : LabourHomeScreen(),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
