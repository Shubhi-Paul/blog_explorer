import 'package:blog_explorer/contants/colors.dart';
import 'package:flutter/material.dart';

class WaitCard extends StatelessWidget {
  const WaitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: lmcontrast,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Collecting Latest Blogs For You",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: lmbglight,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              'assets/searching.png',
              height: 300,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
