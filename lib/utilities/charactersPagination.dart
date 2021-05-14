import 'package:dart_ice_and_fire/models/characters.dart';
import 'package:dart_ice_and_fire/services/iceFireAPI.dart';
import 'package:dart_ice_and_fire/services/iceFireState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final characterPaginationController =
    StateNotifierProvider<CharacterPaginationController, CharactersPagination>(
        (ref) {
  final characterPaginationService = ref.read(allCharactersFuture!);
  return CharacterPaginationController(characterPaginationService);
});

class CharactersPagination {
  final List<Characters>? characters;
  final int? page;

  CharactersPagination({this.characters, this.page});

//Initial state when the API is called initailly
  CharactersPagination.initial()
      : characters = [],
        page = 1;

  CharactersPagination copyWith({
    List<Characters>? characters,
    int? page,
  }) {
    return CharactersPagination(
        characters: characters ?? this.characters, page: page ?? this.page);
  }
}

class CharacterPaginationController
    extends StateNotifier<CharactersPagination> {
  final _charactersService = GetIt.I.get<IceFireApi>();
  CharacterPaginationController(
    _charactersService, [
    CharactersPagination? state,
  ]) : super(state ?? CharactersPagination.initial()) {
    getCharacters();
  }

  Future<void> getCharacters() async {
    final getCharactersResponse =
        await _charactersService.fetchCharacters(state.page);
    state = state.copyWith(
        characters: [...state.characters!, ...getCharactersResponse],
        page: state.page! + 1);
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 10 == 0 && itemPosition != 0;
    final pageToRequest = itemPosition ~/ 10;

    if (requestMoreData && pageToRequest + 1 >= state.page!) {
      getCharacters();
    }
  }
}
