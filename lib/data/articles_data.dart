class Article {
  final String id;
  final String imageUrl;
  final String title;

  // extra
  final String category;

  Article(
      {required this.id,
      required this.imageUrl,
      required this.title,
      required this.category});

  @override
  String toString() {
    return 'Article{id: $id, imageUrl: $imageUrl, title: $title, category: $category}';
  }
}
