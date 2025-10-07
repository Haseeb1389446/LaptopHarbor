import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/Screens/login.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                "assets/images/logo.png", // <-- Tumhara logo
                height: 100,
              ),
              const SizedBox(height: 40),

              // Title
              const Text(
                "Create Account",
                style: TextStyle(
                  color: Color(0xFF062245),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Sign up to get started",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 30),

            Form(
              key: formKey,
              child: Column(
                children: [
              // Full Name
              TextFormField(
                controller: nameController,
                validator: (value){
                  if (value!.isEmpty) {
                    return "Name field must not be empty";
                  } else if(value.length < 3) {
                    return "Name field must contain 3 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Color(0xFF062245)),
                  hintText: "Full Name",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Color(0xFFF05105), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Email
              TextFormField(
                controller: emailController,
                validator: (value){
                  if (value!.isEmpty) {
                    return "Email field must not be empty";
                  } else if(!value.contains("@")) {
                    return "Name field must contain @ symbol";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF062245)),
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Color(0xFFF05105), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password
              TextFormField(
                controller: passwordController,
                validator: (value){
                  if (value!.isEmpty) {
                    return "Password field must not be empty";
                  } else if(value.length < 8) {
                    return "Name field must contain 8 characters";
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF062245)),
                  hintText: "Password",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Color(0xFFF05105), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Signup Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF05105),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _auth.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((res) async {
                        if (!(res.user == null)) {
                          await res.user?.updateDisplayName(nameController.text.trim());
                          await res.user?.reload();
                          User? updatedUser = FirebaseAuth.instance.currentUser;
                          print("User display name: ${updatedUser?.displayName}");
                        }

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User has been created Successfully")));
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
                      });

                    nameController.clear();
                    emailController.clear();
                    passwordController.clear();

                      // print(nameController.text);
                      // print(emailController.text);
                      // print(passwordController.text);
                    }
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ],
              ) 
            ),


              // Already have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ",
                      style: TextStyle(color: Colors.black87)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFF062245),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
