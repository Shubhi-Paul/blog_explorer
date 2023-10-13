import 'package:blog_explorer/contants/text.dart';
import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/providers/bookmark_article_provider.dart';
import 'package:blog_explorer/view/widgets/custom_image_bg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleDetailPage extends StatefulWidget {
  final Article blog;
  const ArticleDetailPage({required this.blog, super.key});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(height: 500, width: double.infinity, child: customCachedNetworkImageBG(widget.blog.imageUrl)),
          Container(
            height: 500,
            width: double.infinity,
            color: Colors.black26,
          ),
          Positioned(
            top: 48,
            left: 32,
            child: IconButton(
              icon: const Icon(
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
            child: Consumer<BookmarkProvider>(builder: (conntext, provider, child) {
              return IconButton(
                icon: provider.isBookmarked(widget.blog)
                    ? const Icon(
                        Icons.bookmark,
                        size: 30,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.bookmark_border,
                        size: 30,
                        color: Colors.white,
                      ),
                onPressed: () => provider.toggleBookmark(widget.blog),
              );
            }),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 150, left: 32, right: 32),
                child: Text(
                  widget.blog.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 32, right: 32),
                child: const Text(
                  "Written by XYZ ",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 350),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration:
                    const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
                child: const Text(extraData),
              ),
            ),
          )
        ],
      ),
    );
  }
}
