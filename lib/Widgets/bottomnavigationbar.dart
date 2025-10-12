import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/Screens/cart.dart';
import 'package:laptop_harbor/Screens/home.dart';
import 'package:laptop_harbor/Screens/productlisting.dart';
import 'package:laptop_harbor/Screens/profile.dart';

class BottomnavigationbarWidget extends StatelessWidget {
  final int currentIndex;

  const BottomnavigationbarWidget({super.key, required this.currentIndex});

  static final List<Widget> screens = [
    const HomeScreen(),
    const ProductListingScreen(),
    const CartScreen(),
    const ProfileScreen(),
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
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.device_laptop), label: 'Products'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), label: 'Profile'),
      ],
    );
  }
}
