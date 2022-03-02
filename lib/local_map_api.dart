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

  Future<void> addPolygon(Polygon newPoly) async {
    print('newPoly: ${newPoly.points}');
    final polygons = {..._mapStreamController.value}..add(newPoly);

    _mapStreamController.add(polygons);

    return;
  }
}


//  const Polygon(
//         polygonId: PolygonId('polygon_1'),
//         points: [
//           LatLng(40.5129092580498, -104.95368238186099),
//           LatLng(40.51304249351129, -104.95346169652385),
//           LatLng(40.512833593348894, -104.95321288462415),
//           LatLng(40.51269706769424, -104.95337082609092),
//         ],
//         fillColor: Colors.green,
//         strokeColor: Colors.green,
//         strokeWidth: 2,
//       )