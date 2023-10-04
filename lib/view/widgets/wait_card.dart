import 'package:flutter/material.dart';


class WaitCard extends StatefulWidget {
  final String status;
  const WaitCard({required this.status, super.key});

  @override
  State<WaitCard> createState() => _WaitCardState();
}

class _WaitCardState extends State<WaitCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      color: Colors.deepPurple.shade300,
      alignment: Alignment.center,
      child: Text(widget.status,
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w700
      ),),
    );
  }
}