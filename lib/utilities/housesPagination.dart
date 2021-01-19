import 'package:dart_ice_and_fire/models/houses.dart';
import 'package:dart_ice_and_fire/services/iceFireAPI.dart';
import 'package:dart_ice_and_fire/services/iceFireState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final housesPaginationController =
    StateNotifierProvider<HousesPaginationController>((ref) {
  final housePaginationService = ref.read(allHousesFuture);
  return HousesPaginationController(housePaginationService);
});

class HousesPagination {
  final List<Houses> houses;
  final int page;

  HousesPagination({this.houses, this.page});

  HousesPagination.initial()
      : houses = [],
        page = 1;

  HousesPagination copyWith({
    List<Houses> houses,
    int page,
  }) {
    return HousesPagination(
      houses: houses ?? this.houses,
      page: page ?? this.page,
    );
  }
}

class HousesPaginationController extends StateNotifier<HousesPagination> {
  final _housesService = GetIt.instance.get<IceFireApi>();

  HousesPaginationController(
    _housesService, [
    HousesPagination state,
  ]) : super(state ?? HousesPagination.initial()) {
    getHouses();
  }

  Future<void> getHouses() async {
    try {
      final getHousesResponse = await _housesService.fetchHouses(state.page);
      state = state.copyWith(
          houses: [...state.houses, ...getHousesResponse],
          page: state.page + 1);
    } catch (e) {
      throw (e);
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 10 == 0 && itemPosition != 0;
    final pageToRequest = itemPosition ~/ 10;

    if (requestMoreData && pageToRequest + 1 >= state.page) {
      getHouses();
    }
  }
}
