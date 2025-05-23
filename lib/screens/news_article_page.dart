import 'package:flutter/material.dart';

class NewsArticlePage extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  const NewsArticlePage({required this.title, required this.content, required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: const TextStyle(color: Colors.green, fontSize: 13)),
            const SizedBox(height: 12),
            Text(content, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}