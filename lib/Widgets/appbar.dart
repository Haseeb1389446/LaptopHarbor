import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      centerTitle: true,
      title: Image.asset(
        "assets/images/banner.png", // 👈 apna logo yahan rakhna
        height: 50,
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Color(0xFF062245)),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Color(0xFF062245)),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.account_circle, color: Color(0xFFF05105)),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(63);
}
