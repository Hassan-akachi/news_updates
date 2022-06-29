import 'package:flutter/foundation.dart';
import"package:json_annotation/json_annotation.dart";
part "article_model.g.dart";
//createToJson is false because of the two classes
@JsonSerializable(createToJson: false)
class Article{
  //defaultValue acts as a null safety
  @JsonKey(defaultValue: "UnKnown")
  final String author;
  final String? title;
  final String? description;
  final String? url;
  @JsonKey(name:"urlToImage")
  final String? imageUrl;
  final String? publishedAt;
  final String? content;
  final ArticleSource source;

  const Article({required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });
 factory Article.fromJson(Map<String,dynamic>json) =>_$ArticleFromJson(json);
}
@JsonSerializable(createToJson: false)
class ArticleSource{
  final String? id;
  final String? name;

  const ArticleSource({
    required this.id,
    required this.name,
  });
  factory ArticleSource.fromJson(Map<String,dynamic>json) =>_$ArticleSourceFromJson(json);
}
