import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/subjects.dart';

class LocalMapApi {
  final _mapStreamController = BehaviorSubject<Set<Polygon>>.seeded(
    {
      const Polygon(
        polygonId: PolygonId('1'),
        points: <LatLng>[
          LatLng(40.511222023410944, -104.95566073641038),
          LatLng(40.511229294586386, -104.95436005561233),
          LatLng(40.510334934090864, -104.9544461300769),
          LatLng(40.51025495005086, -104.95620587468606),
        ],
        fillColor: Colors.green,
        strokeWidth: 2,
      ),
    },
  );

  Stream<Set<Polygon>> getPolygons() =>
      _mapStreamController.asBroadcastStream();

  Future<void> addPolygon() async {
    const newPoly = Polygon(
      polygonId: PolygonId('polygon-a'),
      points: <LatLng>[
        LatLng(40.511222023410944, -104.95566073641038),
        LatLng(40.511229294586386, -104.95436005561233),
        LatLng(40.510334934090864, -104.9544461300769),
        LatLng(40.51025495005086, -104.95620587468606),
      ],
    );
    final polygons = {..._mapStreamController.value}..add(newPoly);

    _mapStreamController.add(polygons);

    return;
  }
}
