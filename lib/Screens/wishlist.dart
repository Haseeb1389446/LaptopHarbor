import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/Widgets/bottomnavigationbar.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Please login to view wishlist")),
      );
    }

    final Stream<QuerySnapshot> wishlistStream = FirebaseFirestore.instance
        .collection('wishlist')
        .where('userId', isEqualTo: user.uid)
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF062245),
        title: const Text("My Wishlist"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: wishlistStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFF05105)));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No items in wishlist ❤️",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          var items = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index].data() as Map<String, dynamic>;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/products/${item["image"]}",
                        width: 60, height: 60, fit: BoxFit.cover),
                  ),
                  title: Text(item["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: Text(
                    "Rs. ${item["price"]}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  trailing: IconButton(
                    icon: const Icon(CupertinoIcons.heart_fill, color: Colors.redAccent),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('wishlist')
                          .doc(items[index].id)
                          .delete();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Item removed from wishlist")),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomnavigationbarWidget(currentIndex: 3),
    );
  }
}
