import 'package:flutter/material.dart';
import 'package:laptop_harbor/Widgets/appbar.dart';
import 'package:laptop_harbor/Widgets/bottomnavigationbar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Preferences",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // 🌙 Dark Mode
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: isDarkMode,
            secondary: const Icon(Icons.dark_mode, color: Colors.indigo),
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
            },
          ),

          // 🔔 Notifications
          SwitchListTile(
            title: const Text("Enable Notifications"),
            value: notificationsEnabled,
            secondary: const Icon(Icons.notifications, color: Colors.deepOrange),
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),

          const Divider(height: 40),

          const Text(
            "Account",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // 🔑 Change Password
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.green),
            title: const Text("Change Password"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Navigate to Change Password Screen
            },
          ),

          // 🚪 Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Handle Logout
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomnavigationbarWidget(currentIndex: 3),
    );
  }
}
