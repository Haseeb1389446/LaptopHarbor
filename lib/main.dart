import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/Screens/login.dart';
import 'package:laptop_harbor/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((res){
    print("Firebase Connected Successfully");
  }).catchError((err){
    print("The error is $err");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // addSampleProducts();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 230,
          width: 230,
        ),
      ),
    );
  }
}

//   Future<void> addSampleProducts() async {
//   final List<Map<String, dynamic>> products = [
//   {
//     "name": "Dell XPS 13 (2024)",
//     "brand": "Dell",
//     "price": 1799,
//     "image": "https://images.unsplash.com/photo-1509395176047-4a66953fd231",
//     "rating": 4.8,
//     "description": "The Dell XPS 13 offers exceptional performance with Intel’s latest Core Ultra processors, an edge-to-edge InfinityEdge display, and an aluminum unibody design. It’s ideal for students, developers, and creative professionals who value portability and power."
//   },
//   {
//     "name": "HP Spectre x360 14",
//     "brand": "HP",
//     "price": 1649,
//     "image": "https://images.unsplash.com/photo-1611078489935-0cb8e7ec0b09",
//     "rating": 4.7,
//     "description": "The HP Spectre x360 14 combines luxury design with high-end specs. Its OLED touchscreen, long battery life, and solid build quality make it a great choice for business users and multitaskers."
//   },
//   {
//     "name": "Apple MacBook Air M3",
//     "brand": "Apple",
//     "price": 1899,
//     "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8",
//     "rating": 4.9,
//     "description": "Apple’s MacBook Air M3 delivers incredible speed and battery life in a thin, silent body. Perfect for productivity, photo editing, and video calls with its high-resolution Retina display and advanced cooling-free design."
//   },
//   {
//     "name": "Lenovo ThinkPad X1 Carbon Gen 11",
//     "brand": "Lenovo",
//     "price": 1749,
//     "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8",
//     "rating": 4.6,
//     "description": "ThinkPad X1 Carbon is known for reliability and performance. This generation features enhanced security, a bright display, and one of the best keyboards in any laptop. It’s a true business-class machine."
//   },
//   {
//     "name": "ASUS ROG Zephyrus G14",
//     "brand": "ASUS",
//     "price": 1999,
//     "image": "https://images.unsplash.com/photo-1602080858428-57174f9431b0",
//     "rating": 4.8,
//     "description": "A compact yet powerful gaming laptop, the ROG Zephyrus G14 brings AMD Ryzen 9 performance, NVIDIA RTX graphics, and a stunning QHD display to portable gaming. Designed for both gamers and creators."
//   },
//   {
//     "name": "Acer Swift Go 14 OLED",
//     "brand": "Acer",
//     "price": 1399,
//     "image": "https://images.unsplash.com/photo-1593642532973-d31b6557fa68",
//     "rating": 4.5,
//     "description": "The Acer Swift Go 14 features a vivid OLED display, lightweight aluminum body, and Intel Evo certification. It’s perfect for professionals who want a balance of performance and portability."
//   },
//   {
//     "name": "MSI Katana 17",
//     "brand": "MSI",
//     "price": 1799,
//     "image": "https://images.unsplash.com/photo-1616627458028-6c8129a0b6b3",
//     "rating": 4.6,
//     "description": "A powerful gaming laptop with 12th Gen Intel Core i7, RTX 4060 GPU, and high refresh rate display. The MSI Katana 17 is built for gamers who demand high frame rates and smooth performance."
//   },
//   {
//     "name": "Microsoft Surface Laptop 5",
//     "brand": "Microsoft",
//     "price": 1599,
//     "image": "https://images.unsplash.com/photo-1611078489935-0cb8e7ec0b09",
//     "rating": 4.7,
//     "description": "Sleek, elegant, and fast — the Surface Laptop 5 is crafted for premium productivity. With PixelSense touchscreen and superior build, it’s the ultimate device for everyday professional use."
//   },
//   {
//     "name": "Gigabyte AERO 16 OLED",
//     "brand": "Gigabyte",
//     "price": 2199,
//     "image": "https://images.unsplash.com/photo-1587202372775-e229f172b9a0",
//     "rating": 4.8,
//     "description": "A dream machine for content creators, the AERO 16 OLED delivers unmatched color accuracy, fast rendering speeds, and gorgeous visuals. Ideal for editing, 3D design, and creative workloads."
//   },
//   {
//     "name": "Razer Blade 16",
//     "brand": "Razer",
//     "price": 2799,
//     "image": "https://images.unsplash.com/photo-1602080858428-57174f9431b0",
//     "rating": 4.9,
//     "description": "Razer Blade 16 combines extreme power in a slim design. With an Intel Core i9, RTX 4080 GPU, and QHD+ Mini LED display, it’s one of the best-performing gaming laptops ever built."
//   },
//   {
//     "name": "HP Envy 16",
//     "brand": "HP",
//     "price": 1599,
//     "image": "https://images.unsplash.com/photo-1603791452906-c7c3b45b13b4",
//     "rating": 4.6,
//     "description": "A powerful creative workstation with 13th Gen Intel processors, dedicated graphics, and a high-quality 16-inch display. Great for productivity, media editing, and immersive entertainment."
//   },
//   {
//     "name": "ASUS ZenBook 14",
//     "brand": "ASUS",
//     "price": 1349,
//     "image": "https://images.unsplash.com/photo-1616627458028-6c8129a0b6b3",
//     "rating": 4.5,
//     "description": "ZenBook 14 combines elegance and performance with ultra-thin bezels, an ergonomic keyboard, and long battery life. It’s made for professionals and students on the move."
//   },
//   {
//     "name": "Acer Predator Helios 16",
//     "brand": "Acer",
//     "price": 2199,
//     "image": "https://images.unsplash.com/photo-1587202372775-e229f172b9a0",
//     "rating": 4.7,
//     "description": "With RTX 4070 GPU, fast refresh display, and exceptional cooling, the Predator Helios 16 delivers top-tier gaming and multitasking performance for serious gamers."
//   },
//   {
//     "name": "Lenovo Legion Pro 5",
//     "brand": "Lenovo",
//     "price": 1899,
//     "image": "https://images.unsplash.com/photo-1611078489935-0cb8e7ec0b09",
//     "rating": 4.7,
//     "description": "Lenovo Legion Pro 5 is a powerhouse gaming laptop with efficient cooling, AMD Ryzen 7 processors, and brilliant performance for heavy workloads and esports gaming."
//   },
//   {
//     "name": "Apple MacBook Pro M3 Pro",
//     "brand": "Apple",
//     "price": 2599,
//     "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8",
//     "rating": 4.9,
//     "description": "MacBook Pro M3 Pro delivers pro-grade performance with an incredible Retina XDR display and 22-hour battery life. It’s built for developers, designers, and video editors."
//   }
// ]
// ;

//   final collection = FirebaseFirestore.instance.collection('products');

//   for (var product in products) {
//     await collection.add(product);
//   }

//   print("✅ Sample products uploaded successfully!");
// }