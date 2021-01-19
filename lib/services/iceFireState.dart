import 'package:dart_ice_and_fire/models/books.dart';
import 'package:dart_ice_and_fire/models/characters.dart';
import 'package:dart_ice_and_fire/models/houses.dart';
import 'package:dart_ice_and_fire/services/iceFireAPI.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:get_it/get_it.dart';

var iceFireAPI = GetIt.instance.get<IceFireApi>();

//Fetching all books
final allBooksFuture = FutureProvider.autoDispose<List<Books>>((ref) async {
  ref.maintainState = true;
  return iceFireAPI.fetchBooks();
});

//Fetching all houses
final allHousesFuture = FutureProvider.autoDispose<List<Houses>>((ref) async {
  ref.maintainState = true;
  return iceFireAPI.fetchHouses();
});

//Fetching all characters
final allCharactersFuture =
    FutureProvider.autoDispose<List<Characters>>((ref) async {
  ref.maintainState = true;
  return iceFireAPI.fetchCharacters();
});

//Fetch One Book
final oneBookFuture =
    FutureProvider.autoDispose.family<Books, String>((ref, identifier) async {
  ref.maintainState = true;
  return iceFireAPI.fetchOneBook(identifier);
});

//Fetch One House
final oneHouseFuture =
    FutureProvider.autoDispose.family<Houses, String>((ref, identifier) async {
  ref.maintainState = true;
  return iceFireAPI.fetchOneHouse(identifier);
});
//Fetch Character Book
final oneCharacterFuture = FutureProvider.autoDispose
    .family<Characters, String>((ref, identifier) async {
  ref.maintainState = true;
  return iceFireAPI.fetchOneCharacter(identifier);
});
