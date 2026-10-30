import 'package:dart_ice_and_fire/models/houses.dart';
import 'package:dart_ice_and_fire/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final housesPaginationController =
    NotifierProvider<HousesPaginationController, HousesPagination>(
      HousesPaginationController.new,
    );

class HousesPagination {
  final List<Houses>? houses;
  final int? page;

  HousesPagination({this.houses, this.page});

  HousesPagination.initial() : houses = [], page = 1;

  HousesPagination copyWith({List<Houses>? houses, int? page}) {
    return HousesPagination(
      houses: houses ?? this.houses,
      page: page ?? this.page,
    );
  }
}

class HousesPaginationController extends Notifier<HousesPagination> {
  bool _loading = false;
  bool _hasMore = true;

  @override
  HousesPagination build() {
    return HousesPagination.initial();
  }

  Future<void> getHouses() async {
    if (_loading || !_hasMore) return;
    _loading = true;
    try {
      final getHousesResponse = await ref
          .read(iceFireApiProvider)
          .fetchHouses(state.page);
      _hasMore = getHousesResponse.isNotEmpty;
      state = state.copyWith(
        houses: [...state.houses!, ...getHousesResponse],
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
      getHouses();
    }
  }
}
