import 'package:blog_explorer/data/articles_data.dart';
import 'package:flutter/foundation.dart';
import 'package:blog_explorer/data/category_data.dart';

class CategoryNotifier extends ChangeNotifier {
  int _selectedCategoryIndex = 1;
  final _myCategories = categories;

  int get selectedCategoryIndex => _selectedCategoryIndex;

  int get categoryLength => categories.length;

  void setCategory(int selectedIndex) {
    // print(selectedIndex);
    _selectedCategoryIndex = selectedIndex+ 1;
    for (var i = 0; i < categoryLength; i++) {
      _myCategories[i].categorySelected = (i == _selectedCategoryIndex);
      //  print(categories[i].categorySelected);
    }
    notifyListeners();
    // print("Listener Notified");
  }

  String getMyCategory(int index) {
    return _myCategories[index].categoryName;
  }

  bool getIsSelected(int index) {
    return _myCategories[index].categorySelected;
  }

  String selectedMyCategory() {
    if (_myCategories.isNotEmpty) {
      return _myCategories[_selectedCategoryIndex].categoryName;
    } else {
      return '';
    }
  }

  List<Article> categoryArticles(List<Article> fetchedList){
    List<Article> newList = [];
    for (Article blog in fetchedList) {
      if (blog.category == _myCategories[selectedCategoryIndex].categoryName) {
        newList.add(blog);
      }
    }
    return newList;
  }
}
