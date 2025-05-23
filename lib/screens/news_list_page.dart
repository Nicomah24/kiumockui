import 'package:flutter/material.dart';
import 'package:student_portal/screens/news_article_page.dart';

class NewsListPage extends StatelessWidget {
  final List<Map<String, String>> newsList;
  const NewsListPage({required this.newsList, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("School Updates")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: newsList.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, i) {
          final news = newsList[i];
          return ListTile(
            title: Text(news['title']!),
            subtitle: Text(news['summary']!),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => NewsArticlePage(
                        title: news['title']!,
                        content:
                            news['summary']! +
                            "\n\nFull article content here...",
                        date: news['date']!,
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
