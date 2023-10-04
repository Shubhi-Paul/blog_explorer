import 'package:blog_explorer/view/screens/article_page.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatefulWidget {
  final String title;
  final String imageUrl;

  const ArticleCard({required this.title, required this.imageUrl, super.key});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
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
        margin: EdgeInsets.only(left: 8, bottom: 16, right: 8),
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: const Offset(
                3.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0.0, 0.0),
              blurRadius: 1.0,
              spreadRadius: 1.0,
            ), //BoxShadow
          ],
        ),
        child: Row(
          children: [
            Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
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
                    )
                    //  Image.network(widget.imageUrl,
                    // ,),
                    )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.title),
            ))
          ],
        ),
      ),
    );
  }
}
