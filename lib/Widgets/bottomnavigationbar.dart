import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/Screens/profile.dart';
import 'package:laptop_harbor/Screens/search.dart';
import 'package:laptop_harbor/Screens/setting.dart';
import 'package:laptop_harbor/main.dart';

class BottomnavigationbarWidget extends StatelessWidget {
  final int currentIndex;

  const BottomnavigationbarWidget({super.key, required this.currentIndex});

  static final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFFF05105), // Orange
      unselectedItemColor: const Color(0xFF062245), // Dark Blue
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        if (value != currentIndex) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screens[value]),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
