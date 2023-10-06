// ignore_for_file: depend_on_referenced_packages

import 'package:blog_explorer/contants/colors.dart';
import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/providers/bookmark_article_provider.dart';
import 'package:blog_explorer/view/screens/article_detail_page.dart';
import 'package:blog_explorer/view/widgets/custom_image_bg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TopPreferenceCard extends StatefulWidget {
  final Article blog;
  const TopPreferenceCard({required this.blog, super.key});

  @override
  State<TopPreferenceCard> createState() => _TopPreferenceCardState();
}

class _TopPreferenceCardState extends State<TopPreferenceCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkProvider>(builder: (context, provider, child) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticleDetailPage(
                        blog: widget.blog,
                      )));
        },
        onDoubleTap: () {
          provider.toggleBookmark(widget.blog);
          Fluttertoast.showToast(
            msg: provider.isBookmarked(widget.blog)? "Article Bookmarked": "Article Removed from Bookmark",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
        child: Container(
          height: 240,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: lmdark,
          ),
          margin: const EdgeInsets.only(left: 8),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 9 / 13,
                  child: customCachedNetworkImageBG(widget.blog.imageUrl),
                ),
              ),
              Container(
                height: 260,
                width: 180,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black38,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.blog.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
