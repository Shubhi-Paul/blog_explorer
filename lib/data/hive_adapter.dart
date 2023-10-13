import 'package:hive/hive.dart';
import 'package:blog_explorer/data/articles_data.dart';

class ArticleAdapter extends TypeAdapter<Article> {
  @override
  final typeId = 0;

  @override
  Article read(BinaryReader reader) {
    return Article(
      id: reader.readString(),
      imageUrl: reader.readString(),
      title: reader.readString(),
      category: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Article obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.imageUrl);
    writer.writeString(obj.title);
    writer.writeString(obj.category);
  }
}
