import 'package:blog_explorer/contants/colors.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  // final VoidCallback onRetry;
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(30),
        color: lmcontrast,
        alignment: Alignment.center,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Unable to Connect, Please check your internet",
              style: TextStyle(
                  color: lmbgdark, fontSize: 30, fontWeight: FontWeight.w700),
            ),
            Image(image:  AssetImage('assets/no_connection.jpeg'),height: 300,fit: BoxFit.contain,),
            Text("Please wait a while after connecting to internet",
                style: TextStyle(
                    color: lmbglight,
                    fontSize: 24,
                    fontWeight: FontWeight.w500))
          ],
        ),
      
    );
  }
}
