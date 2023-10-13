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

void main() async {
  try {await initHiveForFlutter();
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox<Article>('articlesBox');
  await Hive.openBox<Article>('bookmarkedArticlesBox');
} catch(e){
  print('Error initializing Hive: $e');
}

final HttpLink httpLink = HttpLink('https://db.grow90.org/v1/graphql');
  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore()),
  ));

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryNotifier>(create: (_) => CategoryNotifier()),
        ChangeNotifierProvider<BottomNavProvider>(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider<BookmarkProvider>(create: (_) => BookmarkProvider()),
      ],
      child: MyApp(
        client: client,
      )));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MyApp({Key? key, required this.client}): super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Blogs Burg',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(client: client.value,),
      ),
    );
  }
}
