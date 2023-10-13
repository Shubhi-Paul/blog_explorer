import 'package:blog_explorer/contants/config.dart';
import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/data/category_data.dart';
import 'package:http/http.dart' as http;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';
import 'dart:math';
import 'package:hive/hive.dart';

// function for storing the fetched data locally to hive
Future<void> saveDataToHive(List<Article> articles) async {
  print("trying to save to hive 2");
  var box = await Hive.openBox<Article>('articlesBox');
  await box.clear();
  await box.addAll(articles);
}

Future<List<Article>> fetchBlogs() async {
  
  const String getBlogsQuery = r'''
  query GetBlogs {
    blogs {
      id
      image_url
      title
      category
      }
    }
  ''';

  try {
    final QueryResult result = await client.query(QueryOptions(
      document: gql(getBlogsQuery),
    ));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    {
      final List<dynamic> jsonData = result.data?['blogs'];
      print(jsonData);
      List<Article> blogs =
          jsonData.map((blog) => Article(id: blog['id'], imageUrl: blog['image_url'], title: blog['title'], category: getRandomCategory())).toList();

      // print("trying to save to hive 1");
      saveDataToHive(blogs); // Save data to Hive
      // print("Data saved to hive");
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
