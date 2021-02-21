import 'package:flutter/material.dart';
import 'package:sports_news/models/article.dart';
import 'package:sports_news/screens/details_screen.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  ArticleTile(this.article);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsScreen(article),
          ),
        );
      },
      child: Container(
        height: 200,
        width: double.infinity,
        child: Stack(
          children: [
            article.imageUrl != ''
                ? Opacity(
                    opacity: 0.7,
                    child: Image.network(
                      article.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.2),
                    alignment: Alignment.center,
                    child: Text("No Image"),
                  ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                width: MediaQuery.of(context).size.width,
                height: 45,
                color: Colors.black.withOpacity(0.8),
                child: Text(
                  article.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
