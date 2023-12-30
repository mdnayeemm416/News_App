// To parse this JSON data, do
//
//     final carouselslidermodel = carouselslidermodelFromJson(jsonString);

import 'dart:convert';

Carouselslidermodel carouselslidermodelFromJson(String str) => Carouselslidermodel.fromJson(json.decode(str));

String carouselslidermodelToJson(Carouselslidermodel data) => json.encode(data.toJson());

class Carouselslidermodel {
    String status;
    int totalResults;
    List<Article> articles;

    Carouselslidermodel({
        required this.status,
        required this.totalResults,
        required this.articles,
    });

    factory Carouselslidermodel.fromJson(Map<String, dynamic> json) => Carouselslidermodel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
    };
}

class Article {
    Source source;
    String author;
    String title;
    String description;
    String url;
    String urlToImage;
    DateTime publishedAt;
    String content;

    Article({
        required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
    };
}

class Source {
    Id id;
    Name name;

    Source({
        required this.id,
        required this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: idValues.map[json["id"]]!,
        name: nameValues.map[json["name"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "name": nameValues.reverse[name],
    };
}

enum Id {
    TECHCRUNCH
}

final idValues = EnumValues({
    "techcrunch": Id.TECHCRUNCH
});

enum Name {
    TECH_CRUNCH
}

final nameValues = EnumValues({
    "TechCrunch": Name.TECH_CRUNCH
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
