// To parse this JSON data, do
//
//     final books = booksFromJson(jsonString);

import 'dart:convert';

List<Books> booksFromJson(str) => List<Map<String, dynamic>>.from(str)
    .map((e) => Books.fromJson(e))
    .toList(growable: false);

Books bookFromJson(String str) => Books.fromJson(json.decode(str));

String booksToJson(List<Books> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Books {
  Books({
    this.url,
    this.name,
    this.isbn,
    this.authors,
    this.numberOfPages,
    this.publisher,
    this.country,
    this.mediaType,
    this.released,
    this.characters,
    this.povCharacters,
  });

  String url;
  String name;
  String isbn;
  List<String> authors;
  int numberOfPages;
  String publisher;
  String country;
  String mediaType;
  DateTime released;
  List<String> characters;
  List<String> povCharacters;

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        url: json["url"],
        name: json["name"],
        isbn: json["isbn"],
        authors: List<String>.from(json["authors"].map((x) => x)),
        numberOfPages: json["numberOfPages"],
        publisher: json["publisher"],
        country: json["country"],
        mediaType: json["mediaType"],
        released: DateTime.parse(json["released"]).toLocal(),
        characters: List<String>.from(json["characters"].map((x) => x)),
        povCharacters: List<String>.from(json["povCharacters"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
        "isbn": isbn,
        "authors": List<dynamic>.from(authors.map((x) => x)),
        "numberOfPages": numberOfPages,
        "publisher": publisher,
        "country": country,
        "mediaType": mediaType,
        "released": released.toIso8601String(),
        "characters": List<dynamic>.from(characters.map((x) => x)),
        "povCharacters": List<dynamic>.from(povCharacters.map((x) => x)),
      };
}
