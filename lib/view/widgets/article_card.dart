import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/providers/bookmark_article_provider.dart';
import 'package:blog_explorer/view/screens/article_detail_page.dart';
import 'package:blog_explorer/view/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ArticleCard extends StatefulWidget {
  final Article blog;

  const ArticleCard({required this.blog, super.key});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailPage(
                  blog: widget.blog,
                ),
              ),
            );
          },
          onDoubleTap: () {
            provider.toggleBookmark(widget.blog);
            Fluttertoast.showToast(
              msg: provider.isBookmarked(widget.blog) ? "Article Bookmarked" : "Article Removed from Bookmark",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black.withOpacity(0.8),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                const BoxShadow(
                  color: Colors.black38,
                  offset: Offset(
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
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(borderRadius: BorderRadius.circular(16), child: customCachedNetworkImage(widget.blog.imageUrl))),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.blog.title),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
