import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptop_harbor/Screens/productdetails.dart';
import 'package:laptop_harbor/Widgets/appbar.dart';
import 'package:laptop_harbor/Widgets/bottomnavigationbar.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  String searchQuery = '';
  String selectedFilter = 'All';
  String selectedSort = 'None';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Heading
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          // 🔹 Search + Filter + Sort
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                // Search box
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),

                // Filter dropdown
                DropdownButton<String>(
                  value: selectedFilter,
                  items: ['All', 'Below 50000', 'Above 50000']
                      .map((filter) => DropdownMenuItem(
                            value: filter,
                            child: Text(filter),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value!;
                    });
                  },
                ),
                const SizedBox(width: 10),

                // Sort dropdown
                DropdownButton<String>(
                  value: selectedSort,
                  items: [
                    'None',
                    'A-Z',
                    'Price: Low to High',
                    'Price: High to Low'
                  ]
                      .map((sort) => DropdownMenuItem(
                            value: sort,
                            child: Text(sort),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSort = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // 🔹 Product Stream
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                // Map products
                var products = snapshot.data!.docs.map((doc) {
                  return {
                    'id': doc.id,
                    ...doc.data() as Map<String, dynamic>,
                  };
                }).toList();

                // 🔸 Search
                products = products
                    .where((p) =>
                        p['name'].toString().toLowerCase().contains(searchQuery))
                    .toList();

                // 🔸 Filter
                if (selectedFilter == 'Below 50000') {
                  products =
                      products.where((p) => p['price'] < 50000).toList();
                } else if (selectedFilter == 'Above 50000') {
                  products =
                      products.where((p) => p['price'] >= 50000).toList();
                }

                // 🔸 Sort
                if (selectedSort == 'A-Z') {
                  products.sort((a, b) => a['name'].compareTo(b['name']));
                } else if (selectedSort == 'Price: Low to High') {
                  products.sort((a, b) => a['price'].compareTo(b['price']));
                } else if (selectedSort == 'Price: High to Low') {
                  products.sort((a, b) => b['price'].compareTo(a['price']));
                }

                if (products.isEmpty) {
                  return const Center(
                      child: Text('No products match your filters'));
                }

                // 🔹 Product Grid
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final data = products[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // ✅ Fix: send productId instead of data
                            builder: (context) => ProductDetailScreen(
                              productId: data['id'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.asset(
                                  "assets/products/${data['image']}",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('Rs. ${data['price']}'),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      Text('${data['rating']}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomnavigationbarWidget(currentIndex: 1),
    );
  }
}
