import 'package:dart_ice_and_fire/models/books.dart';
import 'package:dart_ice_and_fire/models/characters.dart';
import 'package:dart_ice_and_fire/models/houses.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class IceFireApi {
  final Dio iceFireDio = Dio()
    ..options.baseUrl = 'https://www.anapioficeandfire.com/api'
    ..interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: MemCacheStore(),
          policy: CachePolicy.forceCache,
          hitCacheOnErrorExcept: [401, 403],
          priority: CachePriority.normal,
          maxStale: const Duration(days: 30),
        ),
      ),
    );

  Future<List<Books>> fetchBooks() async {
    final booksResponse = await iceFireDio
        .get('/books', queryParameters: {'page': 1, 'pageSize': 12});
    final books = booksFromJson(booksResponse.data);
    return books;
  }

  Future<Books> fetchOneBook(String url) async {
    final bookResponse = await Dio().get(url);
    final book = bookFromJson(bookResponse.data['data']);
    //final book = List<dynamic>.from(bookResponse.data).toList();
    return book;
  }

  Future<List<Houses>> fetchHouses([int? page = 1]) async {
    final housesResponse =
        await iceFireDio.get('/houses', queryParameters: {'page': page});
    final houses = housesFromJson(housesResponse.data);
    return houses;
  }

  Future<Houses> fetchOneHouse(String url) async {
    final houseResponse = await iceFireDio.get(url);
    final house = housesFromJson(houseResponse.data).single;
    return house;
  }

  Future<List<Characters>> fetchCharacters([int? page = 1]) async {
    final charactersResponse =
        await iceFireDio.get('/characters', queryParameters: {'page': page});
    final characters = charactersFromJson(charactersResponse.data);
    return characters;
  }

  Future<Characters> fetchOneCharacter(String url) async {
    final characterResponse = await iceFireDio.get(url);
    final character = charactersFromJson(characterResponse.data).single;
    return character;
  }
}
