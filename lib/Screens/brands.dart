import 'package:flutter/material.dart';
import 'package:laptop_harbor/Screens/brandproducts.dart';
import 'package:laptop_harbor/Widgets/bottomnavigationbar.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  final List<Map<String, String>> brands = const [
    {"name": "Apple", "image": "assets/images/apple.png"},
    {"name": "Dell", "image": "assets/images/dell.png"},
    {"name": "HP", "image": "assets/images/hp.png"},
    {"name": "Lenovo", "image": "assets/images/lenovo.png"},
    {"name": "Asus", "image": "assets/images/asus.png"},
    {"name": "Acer", "image": "assets/images/acer.png"},
    {"name": "MSI", "image": "assets/images/msi.png"},
    {"name": "Samsung", "image": "assets/images/samsung.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Brands", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF062245),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: brands.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final brand = brands[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BrandProductsScreen(brandName: 'apple'),));
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      brand["image"]!,
                      width: 80,
                      height: 60,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.laptop,
                        color: Color(0xFF062245),
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      brand["name"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF062245),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomnavigationbarWidget(currentIndex: 1),
    );
  }
}
