import 'package:flutter/material.dart';

class BottomBarDemo extends StatefulWidget {
  const BottomBarDemo({super.key});

  @override
  State<BottomBarDemo> createState() => _BottomBarDemoState();
}

class _BottomBarDemoState extends State<BottomBarDemo> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text("Home Screen", style: TextStyle(fontSize: 18))),
    Center(child: Text("Search Screen", style: TextStyle(fontSize: 18))),
    Center(child: Text("Profile Screen", style: TextStyle(fontSize: 18))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        backgroundColor: Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed,

        selectedItemColor: const Color(0xFF062245), // Blue
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home, color: Color(0xFFF05105)), // Orange when active
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search, color: Color(0xFFF05105)),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person, color: Color(0xFFF05105)),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
