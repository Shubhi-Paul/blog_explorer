import 'package:blog_explorer/contants/colors.dart';
import 'package:flutter/material.dart';

class bookmarkInstructionCard extends StatelessWidget {
  const bookmarkInstructionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lmbglight,
        ),
        child: const Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            "Seems like you have no bookmark so far",
            style: TextStyle(
              fontSize: 26,
              color: lmcontrast,
            ),
            textAlign: TextAlign.center,
          ),
          Image(image: AssetImage("assets/bookmark.png")),
          Text("To bookmark an article just double tap on it :)", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: lmcontrast)),
        ]),
      ),
    );
  }
}
