import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/Screens/productdetails.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // For carousel
  final List<String> banners = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  // For brands (use small logos)
  final List<Map<String, String>> brands = [
    {'name': 'Dell', 'img': 'assets/images/dell.png'},
    {'name': 'HP', 'img': 'assets/images/hp.png'},
    {'name': 'Apple', 'img': 'assets/images/apple.png'},
    {'name': 'Lenovo', 'img': 'assets/images/lenovo.png'},
    // add more...
  ];

  // Featured products (sample)
  final List<Map<String, dynamic>> featured = [
    {'title': 'MacBook Air', 'img': 'assets/products/lp1.png', 'price': 1299.0},
    {'title': 'HP Pavilion', 'img': 'assets/products/lp2.png', 'price': 899.0},
    {
      'title': 'Lenovo Legion',
      'img': 'assets/products/lp3.png',
      'price': 1099.0,
    },
    {
      'title': 'Dell Inspiron',
      'img': 'assets/products/lp4.png',
      'price': 749.0,
    },
    {'title': 'Asus ROG', 'img': 'assets/products/lp5.png', 'price': 1599.0},
    {
      'title': 'Surface Laptop',
      'img': 'assets/products/lp6.png',
      'price': 1199.0,
    },
  ];

  // Trending list (horizontal simple)
  final List<Map<String, dynamic>> trending = [
    {
      'title': 'Gaming Beast',
      'img': 'assets/images/trend1.jpg',
      'price': 1399.0,
    },
    {
      'title': 'Light & Thin',
      'img': 'assets/images/trend2.jpg',
      'price': 999.0,
    },
    {
      'title': 'Budget Champ',
      'img': 'assets/images/trend3.jpg',
      'price': 499.0,
    },
  ];

  // Reviews sample
  final List<Map<String, dynamic>> reviews = [
    {'name': 'Ali', 'rating': 5, 'text': 'Great laptop and fast delivery!'},
    {'name': 'Sara', 'rating': 4, 'text': 'Good value for money.'},
    {'name': 'Omar', 'rating': 5, 'text': 'Excellent support from seller.'},
  ];

  // Deal of the day (countdown)
  late Duration _dealRemaining;
  Timer? _dealTimer;

  @override
  void initState() {
    super.initState();
    // Set deal to end in 6 hours from now (example)
    _dealRemaining = const Duration(hours: 6);
    _dealTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_dealRemaining.inSeconds <= 0) {
        timer.cancel();
        setState(() => _dealRemaining = Duration.zero);
      } else {
        setState(
          () => _dealRemaining = _dealRemaining - const Duration(seconds: 1),
        );
      }
    });
  }

  @override
  void dispose() {
    _dealTimer?.cancel();
    super.dispose();
  }

  String get dealTimerText {
    final h = _dealRemaining.inHours.toString().padLeft(2, '0');
    final m = (_dealRemaining.inMinutes % 60).toString().padLeft(2, '0');
    final s = (_dealRemaining.inSeconds % 60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  // UI helpers
  TextStyle get sectionTitleStyle => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xFF062245),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HERO / Carousel + CTA
          CarouselSlider(
            options: CarouselOptions(
              height: 190,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1.1, // thoda space dono sides me
              autoPlayCurve: Curves.easeInOut,
              autoPlayAnimationDuration: const Duration(seconds: 2),
            ),
            items: banners.map((path) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        path,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // 🔹 Gradient overlay for elegant look
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                              Colors.black.withOpacity(0.2),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          // CATEGORIES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Categories", style: sectionTitleStyle),
              TextButton(onPressed: () {}, child: const Text("View All")),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _categoryChip(
                  "Gaming",
                  Icons.sports_esports,
                  Colors.deepPurple,
                ),
                _categoryChip("Business", Icons.work, Colors.blue),
                _categoryChip("Student", Icons.school, Colors.green),
                _categoryChip("2-in-1", Icons.tablet_mac, Colors.orange),
                _categoryChip("Editing", Icons.video_call, Colors.red),
                _categoryChip("Budget", Icons.attach_money, Colors.teal),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // TOP BRANDS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Top Brands", style: sectionTitleStyle),
              TextButton(onPressed: () {}, child: const Text("View All")),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final b = brands[i];
                return _brandChip(b['name']!, b['img']!);
              },
            ),
          ),
          const SizedBox(height: 20),

          // FEATURED PRODUCTS GRID (longer list)
          Text("Featured Products", style: sectionTitleStyle),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: featured.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final p = featured[index];
              return _productCard(p['title'], p['img'], p['price']);
            },
          ),
          const SizedBox(height: 20),

          // DEAL OF THE DAY (highlight)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Deal of the Day", style: sectionTitleStyle),
              TextButton(onPressed: () {}, child: const Text("See all deals")),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            color: const Color(0xFFF05105),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "MacBook Pro 14\"",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Save 20% - Limited time offer",
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF062245),
                              ),
                              onPressed: () {},
                              child: const Text("Buy Now"),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Ends in:",
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                dealTimerText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/macbook.jpg',
                        fit: BoxFit.cover,
                        height: 110,
                        errorBuilder: (_, __, ___) =>
                            Container(color: Colors.grey[300]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // TRENDING HORIZONTAL
          Text("Trending Now", style: sectionTitleStyle),
          const SizedBox(height: 10),
          SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trending.length,
              itemBuilder: (context, i) {
                final t = trending[i];
                return _trendingCard(t['title'], t['img'], t['price']);
              },
            ),
          ),
          const SizedBox(height: 20),

          // REVIEWS
          Text("Customer Reviews", style: sectionTitleStyle),
          const SizedBox(height: 10),
          Column(
            children: reviews.map((r) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(r['name'][0]),
                    backgroundColor: const Color(0xFFF05105),
                  ),
                  title: Row(
                    children: [
                      Text(r['name']),
                      const SizedBox(width: 8),
                      _ratingStars(r['rating']),
                    ],
                  ),
                  subtitle: Text(r['text']),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // PROMO BANNERS (horizontal)
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _promoBanner(
                  "Back to School Sale",
                  "Up to 25% off",
                  Colors.purple,
                ),
                _promoBanner(
                  "Free Delivery",
                  "On orders above \$500",
                  Colors.teal,
                ),
                _promoBanner(
                  "Student Discount",
                  "Show ID & save",
                  Colors.orange,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // BLOG / ARTICLES
          Text("From Our Blog", style: sectionTitleStyle),
          const SizedBox(height: 10),
          Column(
            children: [
              _blogCard(
                "How to choose a laptop in 2025",
                "assets/images/blog1.jpg",
              ),
              _blogCard(
                "Top 10 laptops for students",
                "assets/images/blog2.jpg",
              ),
            ],
          ),
          const SizedBox(height: 20),

          // NEWSLETTER
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Color(0xFFF05105),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Text(
                    "Subscribe to our newsletter",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Subscribe"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ------------------ Small UI widgets ------------------

  Widget _categoryChip(String title, IconData icon, Color color) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _brandChip(String name, String imgPath) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        imgPath,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Center(child: Text(name[0])),
      ),
    );
  }

  Widget _productCard(String title, String imgPath, double price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailScreen(),));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  imgPath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) =>
                      Container(color: Colors.grey[200]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "\$${price.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Color(0xFFF05105),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _trendingCard(String title, String imgPath, double price) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              imgPath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${price.toStringAsFixed(0)}",
                  style: const TextStyle(color: Color(0xFFF05105)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoBanner(String title, String subtitle, Color color) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: TextStyle(color: color.withOpacity(0.8))),
        ],
      ),
    );
  }

  Widget _blogCard(String title, String imgPath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: Image.asset(
              imgPath,
              width: 110,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Read more about choosing the best laptop for your needs.",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // star rating widget
  Widget _ratingStars(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (i) => Icon(
          i < count ? Icons.star : Icons.star_border,
          size: 14,
          color: Colors.amber,
        ),
      ),
    );
  }
}
