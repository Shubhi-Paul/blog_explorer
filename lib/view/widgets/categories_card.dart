import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_explorer/providers/category_provider.dart';

class CategoryCard extends StatelessWidget {
  final int categoryIndex;
  final String category;
  final bool isSelected;

  const CategoryCard({super.key, 
    required this.categoryIndex,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryNotifier>(
      builder: (context, categoryNotifier, child) {
        return GestureDetector(
          onTap: () => categoryNotifier.setCategory(categoryIndex),
          child: Container(
            padding: const EdgeInsets.only(left: 16, top: 8),
            alignment: Alignment.center,
            child: Text(
              category,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w300,
              ),
            ),
          ),
        );
      },
    );
  }
}
