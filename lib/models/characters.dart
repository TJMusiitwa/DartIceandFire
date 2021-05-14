// To parse this JSON data, do
//
//     final characters = charactersFromJson(jsonString);

import 'dart:convert';

List<Characters> charactersFromJson(str) => List<Map<String, dynamic>>.from(str)
    .map((e) => Characters.fromJson(e))
    .toList(growable: false);

String charactersToJson(List<Characters> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Characters {
  Characters({
    this.url,
    this.name,
    this.gender,
    this.culture,
    this.born,
    this.died,
    this.titles,
    this.aliases,
    this.father,
    this.mother,
    this.spouse,
    this.allegiances,
    this.books,
    this.povBooks,
    this.tvSeries,
    this.playedBy,
  });

  String? url;
  String? name;
  String? gender;
  String? culture;
  String? born;
  String? died;
  List<String>? titles;
  List<String>? aliases;
  String? father;
  String? mother;
  String? spouse;
  List<String>? allegiances;
  List<String>? books;
  List<dynamic>? povBooks;
  List<String>? tvSeries;
  List<String>? playedBy;

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        url: json['url'],
        name: json['name'],
        gender: json['gender'],
        culture: json['culture'],
        born: json['born'],
        died: json['died'],
        titles: List<String>.from(json['titles'].map((x) => x)),
        aliases: List<String>.from(json['aliases'].map((x) => x)),
        father: json['father'],
        mother: json['mother'],
        spouse: json['spouse'],
        allegiances: List<String>.from(json['allegiances'].map((x) => x)),
        books: List<String>.from(json['books'].map((x) => x)),
        povBooks: List<dynamic>.from(json['povBooks'].map((x) => x)),
        tvSeries: List<String>.from(json['tvSeries'].map((x) => x)),
        playedBy: List<String>.from(json['playedBy'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'name': name,
        'gender': gender,
        'culture': culture,
        'born': born,
        'died': died,
        'titles': List<dynamic>.from(titles!.map((x) => x)),
        'aliases': List<dynamic>.from(aliases!.map((x) => x)),
        'father': father,
        'mother': mother,
        'spouse': spouse,
        'allegiances': List<dynamic>.from(allegiances!.map((x) => x)),
        'books': List<dynamic>.from(books!.map((x) => x)),
        'povBooks': List<dynamic>.from(povBooks!.map((x) => x)),
        'tvSeries': List<dynamic>.from(tvSeries!.map((x) => x)),
        'playedBy': List<dynamic>.from(playedBy!.map((x) => x)),
      };
}
