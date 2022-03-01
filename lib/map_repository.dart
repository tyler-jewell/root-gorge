import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/local_map_api.dart';

class MapRepository {
  MapRepository({required LocalMapApi localMapApi})
      : _localMapApi = localMapApi;

  final LocalMapApi _localMapApi;

  Stream<Set<Polygon>> getPolygons() => _localMapApi.getPolygons();

  Future<void> addPolygon(Polygon newPoly) => _localMapApi.addPolygon(newPoly);
}
