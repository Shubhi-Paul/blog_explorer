import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/data/category_data.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:blog_explorer/contants/query.dart';

// function for storing the fetched data locally to hive
Future<void> saveDataToHive(List<Article> articles) async {
  var box = Hive.box<Article>('articlesBox');
  await box.clear();
  await box.addAll(articles);
}

Future<List<Article>> fetchBlogs(GraphQLClient client) async {

  try {
    final QueryResult result = await client.query(QueryOptions(
      document: gql(getBlogsQuery)
    ),
    );
    
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    if (result.isLoading) {
      Article load = Article(id: '404', imageUrl: '', title: 'Loading', category: 'error');
      return [load];
    }

    else {
      final List<dynamic> jsonData = result.data?['getSections'];
      // print(jsonData);
      List<Article> blogs =
          jsonData.map((blog) => Article(id: blog['id'], imageUrl: blog['image_url'], title: blog['title'], category: getRandomCategory())).toList();
      saveDataToHive(blogs);
      return blogs;
    }
  } catch (e) {
    print('Error is : $e');
    // error -> unable to connect to server due to no internet connectivity
    Article error = Article(id: '404', imageUrl: '', title: 'Unable to connect to the server. Make sure you are connected to the internet', category: 'error');
    return [error];
  }
}

// returns the articles which match the category
List<Article> getCustomArticles(String category, List<Article> fetchedList) {
  List<Article> newList = [];
  for (Article blog in fetchedList) {
    if (blog.category == category) {
      newList.add(blog);
    }
  }
  return newList;
}

// assign random categories to the blogs as none is assigned
// (this is an attempt to show that the app can even work with blogs which have categories and/or other sort of details)
Random random = Random();
String getRandomCategory() {
  int randomIndex = random.nextInt(categories.length);
  return categories[randomIndex].categoryName;
}
