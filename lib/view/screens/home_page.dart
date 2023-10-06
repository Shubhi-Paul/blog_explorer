import 'package:blog_explorer/contants/colors.dart';
import 'package:blog_explorer/data/articles_data.dart';
import 'package:blog_explorer/module/api.dart';
import 'package:blog_explorer/providers/bottom_nav_provider.dart';
import 'package:blog_explorer/view/screens/articles_page.dart';
import 'package:blog_explorer/view/screens/bookmark_page.dart';
import 'package:blog_explorer/view/widgets/no_internet.dart';
import 'package:blog_explorer/view/widgets/wait_card.dart';
import 'package:flutter/material.dart';
import 'package:blog_explorer/module/network_connectitivy.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> fetchedList = [];
  List<Article> recommendatedArticles = [];
  late String selectedCategory;
  bool isDataAvailble = false;
  bool isOnline = true;
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;

      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(milliseconds: 500), () {
        switch (_source.keys.toList()[0]) {
          case ConnectivityResult.mobile:
            isOnline = _source.values.toList()[0];
            break;
          case ConnectivityResult.wifi:
            isOnline = _source.values.toList()[0];
            break;
          case ConnectivityResult.none:
          default:
            isOnline = false;
        }

        setState(() {
          isOnline = isOnline;
        });

        if (isOnline) {
          getBlogs();
        } else {
          getArticlesFromHive();
        }
      });
    });
  }

  Future<void> getArticlesFromHive() async {
    try {
      var box = await Hive.openBox<Article>('articlesBox');
      print('Is box empty? ${box.isEmpty}');
      // check if there is older data in hive
      if (box.isNotEmpty) {
        fetchedList = box.values.toList();
        // data available
        isDataAvailble = true;
      }
    } catch (e) {
      print('Error: $e');

      // data unavaiable
      isDataAvailble = false;
    }
  }

  void getBlogs() async {
    try {
      List<Article> fetchedBlogs = await fetchBlogs();
      setState(() {
        if (fetchedBlogs[0].category != 'error') {
          // able to connect to api
          isOnline = true;

          // getting the required blogs
          fetchedList = fetchedBlogs;

          // data available
          isDataAvailble = true;
          print("Data Fetched Successfully");
        } else {
          print(fetchedBlogs[0].title);

          // assuming the error is because of no internet connection
          isDataAvailble = false;
        }
      });
    } catch (e) {
      print('Error is this : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var availablePages = [
      ArticlesPage(
        fetchedList: fetchedList,
      ),
      const BookmarkedArticles()
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: lmbglight,
        elevation: 5,
        title: const Row(
          children: [
            Text("Blogs"),
            Text(
              "Burg",
              style: TextStyle(fontWeight: FontWeight.w700, color: lmcontrast),
            )
          ],
        ),
        actions: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: isOnline
                  ? const Icon(
                      Icons.wifi,
                      color: lmcontrast,
                    )
                  : const Icon(
                      Icons.wifi_off_sharp,
                      color: lmcontrast,
                    ))
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Consumer<BottomNavProvider>(builder: (contect, provider, child) {
        return BottomNavigationBar(
          selectedItemColor: lmcontrast,
          unselectedItemColor: lmdark,
          backgroundColor: lmbglight,
          currentIndex: provider.currentIndex,
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
          onTap: (index) {
            provider.currentIndex = index;
          },
        );
      }),
      body: Builder(
        builder: (context) {
          if (!isOnline && !isDataAvailble) {
            return const NoInternet();
          }
          if (!isDataAvailble) {
            return const WaitCard();
          } else {
            return Consumer<BottomNavProvider>(builder: (contect, provider, child) {
              return availablePages[provider.currentIndex];
            });
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    super.dispose();
  }
}
