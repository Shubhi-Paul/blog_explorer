class MyCategory {
  final String categoryName;
  late bool categorySelected;

  MyCategory({required this.categoryName, required this.categorySelected});
}

MyCategory recommended = MyCategory(categoryName: "Recommendation", categorySelected: false);
MyCategory national = MyCategory(categoryName: "National", categorySelected: true);
MyCategory international = MyCategory(categoryName: "International", categorySelected: false);
MyCategory sports = MyCategory(categoryName: "Sports", categorySelected: false);
MyCategory technology = MyCategory(categoryName: "Technology", categorySelected: false);
MyCategory business = MyCategory(categoryName: "Business", categorySelected: false);

final List<MyCategory> categories = [recommended, national, international, sports, business, technology];

MyCategory? _selectedCategory;