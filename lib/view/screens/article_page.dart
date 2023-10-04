import 'package:blog_explorer/data/extra.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  final String title;
  final String imageUrl;
  const ArticlePage({required this.title,required this.imageUrl, super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: EdgeInsets.all(16),
        // color: Colors.red.shade50,
        child: Stack(
          children: [
            Container(
              height: 500, // Set the fixed height to 500 pixels
              width: double.infinity,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 500, // Set the fixed height to 500 pixels
              width: double.infinity,
              color: Colors.black26,
            ),
            Positioned(
              top: 48,
              left: 32,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              top: 48,
              right: 32,
              child: Icon(
                Icons.bookmark_border,
                size: 30,
                color: Colors.white,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 200, left: 32, right: 32),
                  // alignment: Alignment.topLeft,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
                Container(
                  // alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 20, left: 32, right: 32),
                  child: Text(
                    "Written by XYZ ",
                    style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 350),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 50),
                child: Container(
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Text(extraData),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
