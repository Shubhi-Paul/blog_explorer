import 'package:blog_explorer/contants/colors.dart';
import 'package:blog_explorer/view/widgets/bookmark_instruction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_explorer/providers/bookmark_article_provider.dart';
import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/view/widgets/article_card.dart';
import 'package:blog_explorer/data/category_data.dart';

class BookmarkedArticles extends StatefulWidget {
  const BookmarkedArticles({Key? key});

  @override
  State<BookmarkedArticles> createState() => _BookmarkedArticlesState();
}

class _BookmarkedArticlesState extends State<BookmarkedArticles> {
  final TextEditingController _searchController = TextEditingController();
  MyCategory? _selectedCategory; // Change the type here

  List<Article> _runFilter(String enteredKeyword, MyCategory? selectedCategory, BookmarkProvider provider) {
    List<Article> result = [];

    if (enteredKeyword.isEmpty && selectedCategory == null) {
      result = provider.getBookmarkedArticleList();
    } else {
      result = provider.getBookmarkedArticleList().where((article) {
        bool matchesCategory = selectedCategory == null || article.category.contains(selectedCategory.categoryName); // Use categoryName
        bool matchesKeyword = enteredKeyword.isEmpty || article.title.toLowerCase().contains(enteredKeyword.toLowerCase());

        return matchesCategory && matchesKeyword;
      }).toList();
    }

    return result.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    BookmarkProvider provider = Provider.of<BookmarkProvider>(context);
    List<Article> filteredArticles = _runFilter(_searchController.text, _selectedCategory, provider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: lmbglight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    filteredArticles = _runFilter(value, _selectedCategory, provider);
                  });
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 30,
                    minWidth: 25,
                  ),
                  alignLabelWithHint: true,
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const Text("Need Specific Blogs?",
                  style: TextStyle(
                    fontSize: 16
                  ),),
                  Container(
                    width: 160,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: lmbgdark,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: lmbgdark, width: 1),
                    ),
                    child: DropdownButton<MyCategory>(
                      value: _selectedCategory,
                      onChanged: (MyCategory? newValue) {
                        // Change the type here
                        setState(() {
                          _selectedCategory = newValue;
                          filteredArticles = _runFilter(_searchController.text, _selectedCategory, provider);
                        });
                      },
                      items: [null, ...categories].map<DropdownMenuItem<MyCategory>>((MyCategory? value) {
                        // Change the type here
                        return DropdownMenuItem<MyCategory>(
                          value: value,
                          child: Text(value?.categoryName ?? "Choose a category"),
                        );
                      }).toList(),
                      style: const TextStyle(color: Colors.black), // Customize text color
                      underline: Container(), // Remove the default underline
                      isExpanded: true, // Allow the dropdown to take the full width
                      icon: const Icon(Icons.arrow_drop_down), // Customize the dropdown icon
                      iconSize: 24, // Set the icon size
                      elevation: 16, // Set the dropdown elevation
                      dropdownColor: Colors.white, // Set the dropdown background color
                      // Customize the shape using the decoration property
                      // In this example, I'm using a rounded rectangle border
                    ),
                  ),
                ],
              ),
            ),
            filteredArticles.isEmpty
                ? const bookmarkInstructionCard()
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: filteredArticles.length,
                      itemBuilder: (context, index) {
                        return ArticleCard(
                          blog: filteredArticles[index],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
