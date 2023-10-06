import 'package:blog_explorer/contants/config.dart';
import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/data/category_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:hive/hive.dart';

// function for storing the fetched data locally to hive
Future<void> saveDataToHive(List<Article> articles) async {
  var box = await Hive.openBox<Article>('articlesBox');
  // Clear the box to avoid duplicates (optional)
  await box.clear();
  await box.addAll(articles);
}

Future<List<Article>> fetchBlogs() async {
  const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs/';
  const String adminSecret = keySecret;

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    if (response.statusCode == 200) {
      // Request successful
      final List<dynamic> jsonData = json.decode(response.body)['blogs'];
      List<Article> blogs = jsonData
          .map((blog) => Article(
              id: blog['id'],
              imageUrl: blog['image_url'],
              title: blog['title'],

              // assigning random categories to the blog as none were mentioned
              category: getRandomCategory()))
          .toList();

      // saving the data to hive
      saveDataToHive(blogs);
      print("Data saved to hive");
      return blogs;
    } else {
      // Request failed
      print('Request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');

      // error -> unable to connect due to internal server issue
      Article error = Article(id: '${response.statusCode}', imageUrl: '', title: 'Internal Server Error. Reload after sometime', category: 'error');
      print("Internal server error");
      return [error];
    }
  } catch (e) {
    print('Error $e');

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
