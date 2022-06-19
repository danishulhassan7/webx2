import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mistriandlabours/ui/screens/admin/jobs/jobs_screen.dart';
import 'package:mistriandlabours/ui/screens/admin/labour/labour_screen.dart';
import 'package:mistriandlabours/ui/screens/admin/users/users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentScreen = 0;

  List<Widget> _screens = [
    AJobsScrren(),
    ALabourScreen(),
    AUsersScreen(),
  ];

  void _changeScreen(i) => setState(() {
        _currentScreen = i;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreen],
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 6.0,
        currentIndex: _currentScreen,
        onTap: _changeScreen,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.briefcase_outline),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.construct_outline),
            label: 'Labours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.people_outline),
            label: 'Users',
          ),
        ],
      ),
    );
  }
}
