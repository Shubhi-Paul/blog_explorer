import 'package:blog_explorer/providers/bookmark_article_provider.dart';
import 'package:blog_explorer/providers/bottom_nav_provider.dart';
import 'package:blog_explorer/view/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/hive_adapter.dart';
import 'data/articles_data.dart';
import 'package:provider/provider.dart';
import 'providers/category_provider.dart';
import 'package:flutter/services.dart';

void main() async {
  try {
    // check if hive is initialized
    await Hive.initFlutter();
    Hive.registerAdapter(ArticleAdapter());
    await Hive.openBox<Article>('articlesBox');
    print("Hive initialized");
    await Hive.openBox<Article>('bookmarkedArticlesBox');
    print("Hive bookmarkedArticlesBox opened");
    print("Hive initialized");
  } catch (e) {
    // print error incase hive is not initalized
    print('Error initializing Hive: $e');
  } finally {
    // run the app irrespective of hive initialization
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider<CategoryNotifier>(create: (_) => CategoryNotifier()),
      ChangeNotifierProvider<BottomNavProvider>(create: (_) => BottomNavProvider()),
      ChangeNotifierProvider<BookmarkProvider>(create: (_) => BookmarkProvider()),
    ], child: const MyApp()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      title: 'Blogs Burg',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
