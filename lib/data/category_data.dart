class Category {
  final String categoryName;
  late bool categorySelected;

  Category({required this.categoryName, required this.categorySelected});
}

List<Category> Categories = [
  Category(categoryName: "Recommendation", categorySelected: false),
  Category(categoryName: "National", categorySelected: true),
  Category(categoryName: "International", categorySelected: false),
  Category(categoryName: "Sports", categorySelected: false),
  Category(categoryName: "Technology", categorySelected: false),
  Category(categoryName: "Business", categorySelected: false),
];
