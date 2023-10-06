import 'package:flutter/material.dart';
import 'package:blog_explorer/view/widgets/article_card.dart';
import 'package:blog_explorer/view/widgets/categories_card.dart';
import 'package:blog_explorer/view/widgets/top_preference_card.dart';
import 'package:provider/provider.dart';
import 'package:blog_explorer/providers/category_provider.dart';
import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/module/api.dart';
import 'package:blog_explorer/data/category_data.dart';

class ArticlesPage extends StatefulWidget {
  List<Article> fetchedList;
  ArticlesPage({required this.fetchedList, super.key});
  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  Widget build(BuildContext context) {
  List<Article> recommendatedArticles = getCustomArticles(categories[0].categoryName, widget.fetchedList);
  List<Article> categoryArticles = [];
    return Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                 Container(
                  margin: const EdgeInsets.only(left: 8,bottom: 8),
                  child: const Text(
                    "Recommendations",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recommendatedArticles.length,
                      itemBuilder: (context, index) {
                        return TopPreferenceCard(
                          blog: recommendatedArticles[index],
                        );
                      }),
                ),
                SizedBox(
                    height: 45,
                    child: Consumer<CategoryNotifier>(builder: (context, provider, child) {
    
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.categoryLength - 1,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                                categoryIndex: index, 
                                category: provider.getMyCategory(index+1), 
                                isSelected: provider.getIsSelected(index+1));
                          });
                    })),
                Expanded(
                  child: Consumer<CategoryNotifier>(
                    builder: (context, provider, child) {
                      categoryArticles = provider.categoryArticles(widget.fetchedList);
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: categoryArticles.length,
                          itemBuilder: (context, index) {
                            return ArticleCard(
                              blog: categoryArticles[index],
                            );
                          });
                    },
                  ),
                ),
              ]),
            );
  }
}