import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/data/category_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

Future<List<Article>> fetchBlogs() async {
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs/';
  final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    if (response.statusCode == 200) {
      // Request successful, handle the response data here
      final List<dynamic> jsonData = json.decode(response.body)['blogs'];
      return jsonData.map((blog) => Article(
        id: blog['id'],
        imageUrl: blog['image_url'], 
        title: blog['title'],
        category: getRandomCategory()
        )).toList(); 
        // TODO: add this data to hive


    } else {
      // Request failed
      print('Request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');
      Article error = Article(id:'${response.statusCode}', imageUrl: '', title: 'Oops Internal Server Error... Please reload after sometime !!',category: 'error');
      return [error];
    }
  } catch (e) {
      print ('Error $e');
      Article error = Article(id:'404', imageUrl: '', title: 'Oops Unable to connect to the server. Make sure you are connected to the internet !!',category: 'error');
      // TODO: instead take data from hive
      return [error];
    // Handle any errors that occurred during the request
  }
}

// returns the articles which match the category
List<Article> getCustomArticles(String category, List<Article> fetchedList){
  List<Article> newList = [];
  for(Article blog in fetchedList){
    if(blog.category == category){
      newList.add(blog);
    }
  }
  return newList;
}

Random random = Random();
String getRandomCategory(){
  int randomIndex = random.nextInt(Categories.length);
  return Categories[randomIndex].categoryName;
}




