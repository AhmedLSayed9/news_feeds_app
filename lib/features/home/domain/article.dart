import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';

@freezed
class Article with _$Article {
  const factory Article({
    required String author,
    required String title,
    required String description,
    required String url,
    required String image,
    required DateTime publishDate,
  }) = _Article;
}

@freezed
class Articles with _$Articles {
  const factory Articles({
    required IList<Article> items,
  }) = _Articles;

  factory Articles.emptyArticles() => Articles(
        items: List.generate(6, (index) => _emptyArticle).toIList(),
      );

  static Article get _emptyArticle => Article(
        author: 'author',
        title: 'title\n',
        description: 'description',
        url: 'url',
        image: 'image',
        publishDate: DateTime.now(),
      );
}
