import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final String status;
  final VoidCallback onRetry;
  const ErrorCard({required this.status, required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      color: Colors.deepPurple.shade300,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            status,
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
          ),
          ElevatedButton(
              onPressed: onRetry, // Call the callback function
              child: Text('Retry',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400))),
          Text("Please wait a while after retrying...",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
