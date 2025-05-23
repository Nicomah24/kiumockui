import 'package:flutter/material.dart';

class NewsFeedSection extends StatelessWidget {
  final List<Map<String, String>> newsList;
  final VoidCallback onReadMore;
  final Function(int) onArticleTap;
  const NewsFeedSection({
    required this.newsList,
    required this.onReadMore,
    required this.onArticleTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Feed", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            TextButton.icon(
              onPressed: onReadMore,
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: const Text("Read more..."),
            ),
          ],
        ),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: newsList.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) {
              final news = newsList[i];
              return GestureDetector(
                onTap: () => onArticleTap(i),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 3,
                  child: Container(
                    width: 260,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(news['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 8),
                        Text(news['summary']!, maxLines: 3, overflow: TextOverflow.ellipsis),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 14, color: Colors.green),
                            const SizedBox(width: 4),
                            Text(news['date']!, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}