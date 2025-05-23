import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:student_portal/screens/dashboard_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      body: Stack(
        children: [
          // Background image with blur and dark overlay
          SizedBox.expand(
            child: Image.asset('login_background.jpg', fit: BoxFit.cover),
          ),
          SizedBox.expand(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          ),
          // Main content
          Center(child: isMobile ? _MobileLayout() : _DesktopLayout()),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: _SignInForm());
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white, // Solid white background
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo with rounded corners
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'KIU_logo.png',
              width: 120,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 14),
          // Welcome message
          Text(
            "Welcome to Student Portal",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              foreground:
                  Paint()
                    ..shader = LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 39, 166, 82),
                        const Color.fromARGB(255, 40, 181, 85),
                      ],
                    ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Your gateway to campus life and academics.",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          // Sign in fields
          TextField(
            decoration: InputDecoration(
              labelText: "Enter reg no. or email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                elevation: 4,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ),
                );
              },
              child: const Text(
                "Sign In",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Info text at the bottom
          Text(
            "Please use your registration number or KIU student email address (e.g. xxxxxx@stdwc.kiu.ac.ug) to login.\nFor assistance please visit ICT office.",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
