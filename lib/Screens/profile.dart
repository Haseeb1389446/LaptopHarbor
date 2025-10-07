import 'package:flutter/material.dart';
import 'package:laptop_harbor/Widgets/appbar.dart';
import 'package:laptop_harbor/Widgets/bottomnavigationbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 👤 User Info
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
            const SizedBox(height: 12),
            const Text("John Doe",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("johndoe@gmail.com",
                style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 20),

            /// 📊 User Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                profileStat("Orders", "12"),
                profileStat("Wishlist", "5"),
                profileStat("Cart", "3"),
              ],
            ),

            const SizedBox(height: 30),

            /// ⚙️ Options List
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Column(
                children: [
                  optionTile(Icons.edit, "Edit Profile"),
                  optionTile(Icons.shopping_bag, "My Orders"),
                  optionTile(Icons.favorite, "Wishlist"),
                  optionTile(Icons.settings, "Settings"),
                  optionTile(Icons.logout, "Logout", isLogout: true),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomnavigationbarWidget(currentIndex: 3),
    );
  }

  /// 🔹 Profile Stat Widget
  Widget profileStat(String title, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  /// 🔹 Option Tile Widget
  Widget optionTile(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.blue),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
    
  }
}
