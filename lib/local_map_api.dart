import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/subjects.dart';

class LocalMapApi {
  final _mapStreamController = BehaviorSubject<Set<Polygon>>.seeded(
    {
      const Polygon(polygonId: PolygonId('1')),
    },
  );

  Stream<Set<Polygon>> getPolygons() =>
      _mapStreamController.asBroadcastStream();

  Future<void> addPolygon() async {
    final newPoly = Polygon(
      polygonId: const PolygonId("polygon-a"),
      points: <LatLng>{
        const LatLng(37.4219999, -122.0862462),
        const LatLng(37.4220099, -122.0862462),
        const LatLng(37.4220099, -122.0862462),
        const LatLng(37.4219999, -122.0862462),
      },
      }
    );
    final polygons = {..._mapStreamController.value}..add(newPoly);

    _mapStreamController.add(polygons);

    return;
  }
}
