import 'package:dart_ice_and_fire/services/iceFireAPI.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final iceFireApiProvider = Provider<IceFireApi>((ref) {
  return IceFireApi();
});
