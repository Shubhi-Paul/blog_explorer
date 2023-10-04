import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String category;
  final bool isSelected;
  const CategoryCard({required this.category, required this.isSelected,super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     color: widget.isSelected ? Colors.white : Colors.transparent,
      //     borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      // margin: EdgeInsets.only(left: 8),
      padding: EdgeInsets.only(left: 16, top: 8),
      alignment: Alignment.center,
      child: Text(widget.category,
      style: TextStyle(
        fontSize: 18,
        fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w300,
      ),),
    );
  }
}
