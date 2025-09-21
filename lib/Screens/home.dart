import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 👋 Welcome Text
          Text(
            "Welcome Back 👋",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF062245), // dark blue
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Explore our latest features and options",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),

          const SizedBox(height: 20),

          // 🔍 Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: Icon(Icons.search, color: Color(0xFF062245)),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 📦 Feature Cards
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildCard(Icons.person, "Profile", Colors.orange),
              _buildCard(Icons.settings, "Settings", Color(0xFF062245)),
              _buildCard(Icons.notifications, "Notifications", Colors.green),
              _buildCard(Icons.help, "Help", Colors.red),
            ],
          ),

          const SizedBox(height: 20),

          // 🔔 Announcement Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFFF05105),
                child: Icon(Icons.campaign, color: Colors.white),
              ),
              title: Text("New Update Available!"),
              subtitle: Text("Check out the latest features we’ve added."),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable card widget
  Widget _buildCard(IconData icon, String title, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {}, // TODO: Navigation laga sakte ho
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
