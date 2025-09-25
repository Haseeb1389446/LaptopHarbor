import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔥 Banner / Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: [
                'assets/images/banner.jpg',
                'assets/images/banner.jpg',
                'assets/images/banner.jpg',
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(i, fit: BoxFit.cover, width: double.infinity),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            /// 📦 Category Cards
            Text("Categories", style: sectionTitleStyle),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categoryCard("Gaming", Icons.sports_esports, Colors.deepPurple),
                  categoryCard("Business", Icons.work, Colors.blue),
                  categoryCard("Student", Icons.school, Colors.green),
                  categoryCard("Editing", Icons.video_call, Colors.orange),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🏷️ Top Brands
            Text("Top Brands", style: sectionTitleStyle),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  brandCard("Dell", "assets/images/dell.png"),
                  brandCard("HP", "assets/images/hp.png"),
                  brandCard("Apple", "assets/images/apple.png"),
                  brandCard("Lenovo", "assets/images/lenovo.png"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 💻 Featured Products
            Text("Featured Products", style: sectionTitleStyle),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                productCard("MacBook Air", "assets/images/macbook.jpg", 1299),
                productCard("HP Pavilion", "assets/images/hp_pavilion.jpg", 899),
                productCard("Lenovo Legion", "assets/images/lenovo_legion.jpg", 1099),
                productCard("Dell Inspiron", "assets/images/dell_inspiron.jpg", 749),
              ],
            ),

            const SizedBox(height: 20),

            /// 🎁 Promo Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              color: const Color(0xFFF05105),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Icon(Icons.local_offer, color: Colors.white, size: 40),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Limited Time Offer: Get up to 30% off on selected laptops!",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// 🔹 Styles
  TextStyle get sectionTitleStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF062245),
      );

  /// 🧩 Category Card Widget
  Widget categoryCard(String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      width: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  /// 🏷️ Brand Card Widget
  Widget brandCard(String name, String imagePath) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(imagePath),
    );
  }

  /// 💻 Product Card Widget
  Widget productCard(String title, String imagePath, double price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: InkWell(
        onTap: () {
          // TODO: Navigate to Product Detail
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text("\$${price.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           // 👋 Welcome Text
//           Text(
//             "Welcome Back 👋",
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF062245), // dark blue
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             "Explore our latest features and options",
//             style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//           ),

//           const SizedBox(height: 20),

//           // 🔍 Search Bar
//           TextField(
//             decoration: InputDecoration(
//               hintText: "Search...",
//               prefixIcon: Icon(Icons.search, color: Color(0xFF062245)),
//               filled: true,
//               fillColor: Colors.grey[200],
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           // 📦 Feature Cards
//           GridView.count(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             children: [
//               _buildCard(Icons.person, "Profile", Colors.orange),
//               _buildCard(Icons.settings, "Settings", Color(0xFF062245)),
//               _buildCard(Icons.notifications, "Notifications", Colors.green),
//               _buildCard(Icons.help, "Help", Colors.red),
//             ],
//           ),

//           const SizedBox(height: 20),

//           // 🔔 Announcement Card
//           Card(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             elevation: 3,
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Color(0xFFF05105),
//                 child: Icon(Icons.campaign, color: Colors.white),
//               ),
//               title: Text("New Update Available!"),
//               subtitle: Text("Check out the latest features we’ve added."),
//               trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Reusable card widget
//   Widget _buildCard(IconData icon, String title, Color color) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 3,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: () {}, // TODO: Navigation laga sakte ho
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, size: 40, color: color),
//               const SizedBox(height: 10),
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
