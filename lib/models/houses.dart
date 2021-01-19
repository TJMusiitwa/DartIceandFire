// To parse this JSON data, do
//
//     final houses = housesFromJson(jsonString);

import 'dart:convert';

List<Houses> housesFromJson(str) => List<Map<String, dynamic>>.from(str)
    .map((e) => Houses.fromJson(e))
    .toList(growable: false);

String housesToJson(List<Houses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Houses {
  Houses({
    this.url,
    this.name,
    this.region,
    this.coatOfArms,
    this.words,
    this.titles,
    this.seats,
    this.currentLord,
    this.heir,
    this.overlord,
    this.founded,
    this.founder,
    this.diedOut,
    this.ancestralWeapons,
    this.cadetBranches,
    this.swornMembers,
  });

  String url;
  String name;
  String region;
  String coatOfArms;
  String words;
  List<String> titles;
  List<String> seats;
  String currentLord;
  String heir;
  String overlord;
  String founded;
  String founder;
  String diedOut;
  List<String> ancestralWeapons;
  List<String> cadetBranches;
  List<String> swornMembers;

  factory Houses.fromJson(Map<String, dynamic> json) => Houses(
        url: json["url"],
        name: json["name"],
        region: json["region"],
        coatOfArms: json["coatOfArms"],
        words: json["words"],
        titles: List<String>.from(json["titles"].map((x) => x)),
        seats: List<String>.from(json["seats"].map((x) => x)),
        currentLord: json["currentLord"],
        heir: json["heir"],
        overlord: json["overlord"],
        founded: json["founded"],
        founder: json["founder"],
        diedOut: json["diedOut"],
        ancestralWeapons:
            List<String>.from(json["ancestralWeapons"].map((x) => x)),
        cadetBranches: List<String>.from(json["cadetBranches"].map((x) => x)),
        swornMembers: List<String>.from(json["swornMembers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
        "region": region,
        "coatOfArms": coatOfArms,
        "words": words,
        "titles": List<dynamic>.from(titles.map((x) => x)),
        "seats": List<dynamic>.from(seats.map((x) => x)),
        "currentLord": currentLord,
        "heir": heir,
        "overlord": overlord,
        "founded": founded,
        "founder": founder,
        "diedOut": diedOut,
        "ancestralWeapons": List<dynamic>.from(ancestralWeapons.map((x) => x)),
        "cadetBranches": List<dynamic>.from(cadetBranches.map((x) => x)),
        "swornMembers": List<dynamic>.from(swornMembers.map((x) => x)),
      };
}
