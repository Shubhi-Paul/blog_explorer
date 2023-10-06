import 'package:flutter/foundation.dart';
import 'package:blog_explorer/data/articles_data.dart';
import 'package:hive/hive.dart';

class BookmarkProvider with ChangeNotifier {
  List<Article> _bookmarkedArticles = [];

  BookmarkProvider() {
    _bookmarkedArticles = Hive.box<Article>('bookmarkedArticlesBox').values.toList();
  }

  List<Article> getBookmarkedArticleList() => _bookmarkedArticles;

  Article getBookmarkedArticle(int index) {
    if (index >= 0 && index < _bookmarkedArticles.length) {
      return _bookmarkedArticles[index];
    } else {
      throw Exception("Index out of bounds");
    }
  }

  int get bookmarkedArticlesLength => _bookmarkedArticles.length;

  void addBookmark(Article article) {
  if (!_bookmarkedArticles.any((a) => a.id == article.id)) {
    _bookmarkedArticles.add(article);
    Hive.box<Article>('bookmarkedArticlesBox').put(article.id, article);
    notifyListeners();
  }
}

  void removeBookmark(Article article) {
    _bookmarkedArticles.remove(article);
    notifyListeners();
  }

bool isBookmarked(Article article) {
  return _bookmarkedArticles.any((a) => a.id == article.id);
}


  void toggleBookmark(Article article) {
  if (isBookmarked(article)) {
    _bookmarkedArticles.removeWhere((a) => a.id == article.id);
    Hive.box<Article>('bookmarkedArticlesBox').delete(article.id);
  } else {
    _bookmarkedArticles.add(article);
    Hive.box<Article>('bookmarkedArticlesBox').put(article.id, article);
  }
  notifyListeners();
}

}
