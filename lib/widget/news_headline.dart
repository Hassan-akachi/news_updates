import 'package:flutter/material.dart';
import 'package:news_updates/models/article_model.dart';

class NewsHeadline extends StatelessWidget {
  final Article article;
  const NewsHeadline({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final publishedAt = article.publishedAt?.split("T")[0];
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        leading: CircleAvatar(
          foregroundImage:article.imageUrl != null
          ? NetworkImage(article.imageUrl!) : null,
          backgroundColor: Colors.blue,
          radius: 20.0,
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children:[ Text(
            article.title!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
            const SizedBox(height: 5,),
            Text(
              article.author,
              style: const TextStyle(fontSize: 10, color: Colors.blueGrey),
            ),
          ]
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              article.source.name ?? "",
              style: const TextStyle(fontSize: 10, color: Colors.blueGrey),
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month_outlined),
                Text(publishedAt ?? "",style: const TextStyle(fontSize: 10, color: Colors.blueGrey))
              ],
            )
          ],
        ),
      ),
    );
  }
}
