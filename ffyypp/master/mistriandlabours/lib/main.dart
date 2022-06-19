import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mistriandlabours/config/app_themes.dart';
import 'package:mistriandlabours/models/app_roles.dart';
import 'package:mistriandlabours/models/app_user.dart';
import 'package:mistriandlabours/services/auth_service.dart';
import 'package:mistriandlabours/services/firestorage_service.dart';
import 'package:mistriandlabours/services/job_application_service.dart';
import 'package:mistriandlabours/services/job_service.dart';
import 'package:mistriandlabours/services/labour_service.dart';
import 'package:mistriandlabours/services/one_signal_service.dart';
import 'package:mistriandlabours/services/user_service.dart';
import 'package:mistriandlabours/ui/screens/admin/home_screen.dart';
import 'package:mistriandlabours/ui/screens/labour/labour_home_screen.dart';
import 'package:mistriandlabours/ui/screens/splash_screen.dart';
import 'package:mistriandlabours/ui/screens/user/user_home_screen.dart';
import 'package:provider/provider.dart';

import 'ui/screens/auth/login_options_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final OneSignalService _oneSignalService = OneSignalService.instance;
  runApp(MyApp(oneSignalService: _oneSignalService));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.oneSignalService,
  }) : super(key: key);

  final OneSignalService oneSignalService;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BaseAuth>(create: (_) => Auth()),
        Provider<OneSignalService>.value(value: oneSignalService),
        Provider<UserService>.value(value: UserService.instance),
        Provider<LabourService>.value(value: LabourService.instance),
        Provider<JobService>.value(value: JobService.instance),
        Provider<FirestorageService>.value(value: FirestorageService()),
        Provider<JobApplicationService>.value(
            value: JobApplicationService.instance),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'labour and maistri',
        theme: AppThemes.appTheme,
        home: LandingScreen(),
      ),
    );
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseAuth>(builder: (context, model, _) {
      return StreamBuilder<AppUser?>(
        stream: model.authStateChanges,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            if (snap.hasData) {
              return StreamBuilder<AppUser>(
                  stream: context.read<UserService>().getUser(snap.data!.id),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      final _role = snap.data!.role;

                      return Provider<AppUser>.value(
                        value: snap.data!,
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: _role == AppRoles.admin
                              ? HomeScreen()
                              : (_role == AppRoles.user
                                  ? UserHomeScreen()
                                  : LabourHomeScreen()),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return LoginOptionsScreen();
            }
          }
        },
      );
    });
  }
}
