import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/Screens/cart.dart';
import 'package:laptop_harbor/Screens/login.dart';
import 'package:laptop_harbor/Screens/order.dart';
import 'package:laptop_harbor/Screens/productlisting.dart';
import 'package:laptop_harbor/Screens/profile.dart';
import 'package:laptop_harbor/Screens/setting.dart';
import 'package:laptop_harbor/Screens/wishlist.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({super.key});

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
      // leading: IconButton(
      //   icon: const Icon(Icons.menu, color: Color(0xFF062245)),
      //   onPressed: () {},
      // ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Color(0xFF062245)),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductListingScreen(),));
          },
        ),
        IconButton(
          icon: const Icon(Icons.account_circle, color: Color(0xFFF05105)),
          onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(),));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(63);
}

/// ✅ Drawer Widget (Menu)
class AppDrawer extends StatelessWidget {
 AppDrawer({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
  // final User? user = _auth.currentUser;
    return Drawer(
      clipBehavior: Clip.none,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 🔹 Drawer Header
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF062245)),
            // accountName: Text(user?.displayName ?? "No Name" , style: TextStyle(fontSize: 18)),
            // accountEmail: Text(user?.email ?? "No Email"),
            accountName: Text("Abdul Haseeb"),
            accountEmail: Text("haseeb@gmail.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Color(0xFF062245)),
            ),
          ),

          // 🔹 Drawer Items
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context); // close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Cart"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen(),));
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Wishlist"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => WishlistScreen(),));
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text("Orders"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrdersScreen(),));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingScreen(),));
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              _auth.signOut().then((res){
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("logout successfully")));
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
              }).catchError((err){
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The Error is $err")));
              });
            },
          ),
        ],
      ),
    );
  }
}
