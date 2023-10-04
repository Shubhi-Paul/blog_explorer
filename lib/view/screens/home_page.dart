import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/data/category_data.dart';
import 'package:blog_explorer/module/api.dart';
import 'package:blog_explorer/view/widgets/article_card.dart';
import 'package:blog_explorer/view/widgets/categories_card.dart';
import 'package:blog_explorer/view/widgets/error_card.dart';
import 'package:blog_explorer/view/widgets/wait_card.dart';
import 'package:blog_explorer/view/widgets/top_preference_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> fetchedList = [];
  List<Article> recommendatedArticles = [];
  List<Article> categoryArticles = [];
  String selectedCategory = Categories[1].categoryName;
  bool isDataAvailble = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();

    getBlogs();
  }

  void getBlogs() async {
    try {
      isError = false;
      List<Article> fetchedBlogs = await fetchBlogs();
      setState(() {
        if (fetchedBlogs[0].category != 'error') {
          fetchedList = fetchedBlogs;
          recommendatedArticles =
              getCustomArticles(Categories[0].categoryName, fetchedBlogs);
          categoryArticles = getCustomArticles(selectedCategory, fetchedBlogs);
          isDataAvailble = true;
          isError = false;
          print(recommendatedArticles);
        } else {
          isError = true;
        }
      });
    } catch (e) {
      print('Error is this : $e');
    }
  }

  // to retry connecting to server incase the internet is connected after opening the app
  void retryFetchingBlogs() {
    getBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
        body: Builder(builder: (context) {
          if (isError) {
            return ErrorCard(
              status: "Unable to Connect, Please check your internet",
              onRetry : retryFetchingBlogs,
            );
          }
          if (!isDataAvailble) {
            return WaitCard(
              status: "Fetching Data ....",
            );
          } else {
            return Container(
              padding: EdgeInsets.only(top: 32, left: 8, right: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Recommendations",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 30),
                      ),
                    ),
                    Container(
                      // color: Colors.red.shade100,
                      height: 260,
                      child: ListView.builder(
                          // shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: recommendatedArticles.length,
                          itemBuilder: (context, index) {
                            return TopPreferenceCard(
                              title: recommendatedArticles[index].title,
                              imageUrl: recommendatedArticles[index].imageUrl,
                            );
                          }),
                    ),
                    Container(
                      // color: Colors.red.shade100,
                      margin: EdgeInsets.only(top: 8),
                      height: 45,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: Categories.length - 1,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory =
                                        Categories[index + 1].categoryName;
                                    for (var i = 0;
                                        i < Categories.length;
                                        i++) {
                                      if (i == index + 1) {
                                        Categories[i].categorySelected = true;
                                        selectedCategory =
                                            Categories[i].categoryName;
                                      } else {
                                        Categories[i].categorySelected = false;
                                      }
                                    }
                                    categoryArticles = getCustomArticles(
                                        selectedCategory, fetchedList);
                                  });
                                },
                                child: CategoryCard(
                                  category: Categories[index + 1].categoryName,
                                  isSelected:
                                      Categories[index + 1].categorySelected,
                                ));
                          }),
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: categoryArticles.length,
                          itemBuilder: (context, index) {
                            return ArticleCard(
                              title: categoryArticles[index].title,
                              imageUrl: categoryArticles[index].imageUrl,
                            );
                          }),
                    ),
                  ]),
            );
          }
        }),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'BlogBurg',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Bookmark',
            ),
          ],
        ));
  }
}
