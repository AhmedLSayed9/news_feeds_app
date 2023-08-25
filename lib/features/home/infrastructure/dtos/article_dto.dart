import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/article.dart';

part 'article_dto.freezed.dart';

part 'article_dto.g.dart';

@Freezed(toJson: false)
class ArticleDto with _$ArticleDto {
  const factory ArticleDto({
    required String? author,
    required String title,
    required String description,
    required String url,
    @JsonKey(name: 'urlToImage') required String image,
    @JsonKey(name: 'publishedAt') required DateTime publishDate,
  }) = _ArticleDto;

  const ArticleDto._();

  factory ArticleDto.fromJson(Map<String, dynamic> json) => _$ArticleDtoFromJson(json);

  Article toDomain() {
    return Article(
      author: author ?? '',
      title: title,
      description: description,
      url: url,
      image: image,
      publishDate: publishDate,
    );
  }
}

@Freezed(toJson: false)
class ArticlesDto with _$ArticlesDto {
  const factory ArticlesDto({
    required IList<ArticleDto> articles,
  }) = _ArticlesDto;

  const ArticlesDto._();

  factory ArticlesDto.fromJson(Map<String, dynamic> json) => _$ArticlesDtoFromJson(json);

  Articles toDomain() {
    return Articles(items: articles.map((e) => e.toDomain()).toIList());
  }
}
