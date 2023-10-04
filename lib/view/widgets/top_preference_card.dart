import 'package:blog_explorer/view/screens/article_page.dart';
import 'package:flutter/material.dart';

class TopPreferenceCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  const TopPreferenceCard(
      {required this.title, required this.imageUrl, super.key});

  @override
  State<TopPreferenceCard> createState() => _TopPreferenceCardState();
}

class _TopPreferenceCardState extends State<TopPreferenceCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticlePage(
                      title: widget.title,
                      imageUrl: widget.imageUrl,
                    )));
      },
      onDoubleTap: (){}, // TODO: bookmark
      child: Container(
        height: 260,
        width: 180,
        margin: const EdgeInsets.only(left: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 9 / 13,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
              height: 260,
              width: 180,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black38,
              ),
              alignment: Alignment.center,
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
