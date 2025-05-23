import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});
  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    return Container(
      width: double.infinity,
      color: Colors.green[900],
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ), // Reduced vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Kampala International University $year",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const Text(
            "Created by Watiti Nicholas | nicholaswatiti23@gmail.com",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
