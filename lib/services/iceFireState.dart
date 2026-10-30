import 'package:dart_ice_and_fire/models/books.dart';
import 'package:dart_ice_and_fire/models/characters.dart';
import 'package:dart_ice_and_fire/models/houses.dart';
import 'package:dart_ice_and_fire/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Fetching all books
final FutureProvider<List<Books>> allBooksFuture =
    FutureProvider.autoDispose<List<Books>>((ref) async {
      ref.keepAlive();
      return ref.watch(iceFireApiProvider).fetchBooks();
    });

//Fetching all houses
final FutureProvider<List<Houses>> allHousesFuture =
    FutureProvider.autoDispose<List<Houses>>((ref) async {
      ref.keepAlive();
      return ref.watch(iceFireApiProvider).fetchHouses();
    });

//Fetching all characters
final FutureProvider<List<Characters>> allCharactersFuture =
    FutureProvider.autoDispose<List<Characters>>((ref) async {
      ref.keepAlive();
      return ref.watch(iceFireApiProvider).fetchCharacters();
    });

//Fetch One Book
final oneBookFuture = FutureProvider.family<Books, String>((
  ref,
  identifier,
) async {
  ref.keepAlive();
  return ref.watch(iceFireApiProvider).fetchOneBook(identifier);
});

//Fetch One House
final oneHouseFuture = FutureProvider.family<Houses, String>((
  ref,
  identifier,
) async {
  ref.keepAlive();
  return ref.watch(iceFireApiProvider).fetchOneHouse(identifier);
});
//Fetch Character Book
final oneCharacterFuture = FutureProvider.family<Characters, String>((
  ref,
  identifier,
) async {
  ref.keepAlive();
  return ref.watch(iceFireApiProvider).fetchOneCharacter(identifier);
});
