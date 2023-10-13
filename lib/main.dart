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
import 'package:graphql_flutter/graphql_flutter.dart';
import 'contants/config.dart';

void main() async {
  try {
    // check if hive is initialized
    await Hive.initFlutter();
    print("Hive initialized");
    Hive.registerAdapter(ArticleAdapter());
    
    print("Hive articlesBox opened");
    
    print("Hive bookmarkedArticlesBox opened");

    final HttpLink httpLink = HttpLink(
      'https://intent-kit-16.hasura.app/api/rest/blogs/',
    );
    final AuthLink authLink = AuthLink(
      getToken: () => 'x-hasura-admin-secret $keySecret', //TODO: correct this
    );

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: link,
      cache: GraphQLCache(), //TODO: check the hive usage here
    ),
    );
    var articleBox = await Hive.openBox<Article>('articlesBox');
    var bookmarkedArticlesBox = Hive.openBox<Article>('bookmarkedArticlesBox');

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
