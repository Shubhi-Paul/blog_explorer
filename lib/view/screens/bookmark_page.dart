import 'package:blog_explorer/contants/colors.dart';
import 'package:blog_explorer/view/widgets/bookmark_instruction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_explorer/providers/bookmark_article_provider.dart';
import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/view/widgets/article_card.dart';
import 'package:blog_explorer/data/category_data.dart';

class BookmarkedArticles extends StatefulWidget {
  const BookmarkedArticles({super.key});

  @override
  State<BookmarkedArticles> createState() => _BookmarkedArticlesState();
}

class _BookmarkedArticlesState extends State<BookmarkedArticles> {
  final TextEditingController _searchController = TextEditingController();
  MyCategory? _selectedCategory;

  List<Article> _runFilter(String enteredKeyword, MyCategory? selectedCategory, BookmarkProvider provider) {
    List<Article> result = [];

    if (enteredKeyword.isEmpty && selectedCategory == null) {
      result = provider.getBookmarkedArticleList();
    } else {
      result = provider.getBookmarkedArticleList().where((article) {
        bool matchesCategory = selectedCategory == null || article.category.contains(selectedCategory.categoryName);
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
                  const Text(
                    "Need Specific Blogs?",
                    style: TextStyle(fontSize: 16),
                  ),
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
                        setState(() {
                          _selectedCategory = newValue;
                          filteredArticles = _runFilter(_searchController.text, _selectedCategory, provider);
                        });
                      },
                      items: [null, ...categories].map<DropdownMenuItem<MyCategory>>((MyCategory? value) {
                        return DropdownMenuItem<MyCategory>(
                          value: value,
                          child: Text(value?.categoryName ?? "Choose a category"),
                        );
                      }).toList(),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      dropdownColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            filteredArticles.isEmpty
                ? const BookmarkInstructionCard()
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
