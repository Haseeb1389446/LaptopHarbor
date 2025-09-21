import 'package:flutter/material.dart';
import 'package:laptop_harbor/Widgets/appbar.dart';
import 'package:laptop_harbor/Widgets/bottomnavigationbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: const Center(child: Text("This is Profile Page")),
      bottomNavigationBar: const BottomnavigationbarWidget(currentIndex: 1),
    );
  }
}
