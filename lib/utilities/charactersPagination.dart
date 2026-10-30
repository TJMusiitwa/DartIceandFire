import 'package:dart_ice_and_fire/models/characters.dart';
import 'package:dart_ice_and_fire/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final characterPaginationController =
    NotifierProvider<CharacterPaginationController, CharactersPagination>(
      CharacterPaginationController.new,
    );

class CharactersPagination {
  final List<Characters>? characters;
  final int? page;

  CharactersPagination({this.characters, this.page});

  //Initial state when the API is called initailly
  CharactersPagination.initial() : characters = [], page = 1;

  CharactersPagination copyWith({List<Characters>? characters, int? page}) {
    return CharactersPagination(
      characters: characters ?? this.characters,
      page: page ?? this.page,
    );
  }
}

class CharacterPaginationController extends Notifier<CharactersPagination> {
  bool _loading = false;
  bool _hasMore = true;

  @override
  CharactersPagination build() {
    return CharactersPagination.initial();
  }

  Future<void> getCharacters() async {
    if (_loading || !_hasMore) return;
    _loading = true;
    try {
      final getCharactersResponse = await ref
          .read(iceFireApiProvider)
          .fetchCharacters(state.page);
      _hasMore = getCharactersResponse.isNotEmpty;
      state = state.copyWith(
        characters: [...state.characters!, ...getCharactersResponse],
        page: state.page! + 1,
      );
    } finally {
      _loading = false;
    }
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
