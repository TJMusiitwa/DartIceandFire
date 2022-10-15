import 'package:dart_ice_and_fire/models/books.dart';
import 'package:dart_ice_and_fire/models/characters.dart';
import 'package:dart_ice_and_fire/models/houses.dart';
import 'package:dart_ice_and_fire/services/iceFireAPI.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

IceFireApi iceFireAPI = GetIt.instance.get<IceFireApi>();

//Fetching all books
final AutoDisposeFutureProvider<List<Books>> allBooksFuture =
    FutureProvider.autoDispose<List<Books>>((ref) async {
  ref.keepAlive();
  return iceFireAPI.fetchBooks();
});

//Fetching all houses
final AutoDisposeFutureProvider<List<Houses>> allHousesFuture =
    FutureProvider.autoDispose<List<Houses>>((ref) async {
  ref.keepAlive();
  return iceFireAPI.fetchHouses();
});

//Fetching all characters
final AutoDisposeFutureProvider<List<Characters>> allCharactersFuture =
    FutureProvider.autoDispose<List<Characters>>((ref) async {
  ref.keepAlive();
  return iceFireAPI.fetchCharacters();
});

//Fetch One Book
final AutoDisposeFutureProviderFamily<Books, String> oneBookFuture =
    FutureProvider.autoDispose.family<Books, String>((ref, identifier) async {
  ref.keepAlive();
  return iceFireAPI.fetchOneBook(identifier);
});

//Fetch One House
final AutoDisposeFutureProviderFamily<Houses, String> oneHouseFuture =
    FutureProvider.autoDispose.family<Houses, String>((ref, identifier) async {
  ref.keepAlive();
  return iceFireAPI.fetchOneHouse(identifier);
});
//Fetch Character Book
final AutoDisposeFutureProviderFamily<Characters, String> oneCharacterFuture =
    FutureProvider.autoDispose
        .family<Characters, String>((ref, identifier) async {
  ref.keepAlive();
  return iceFireAPI.fetchOneCharacter(identifier);
});
