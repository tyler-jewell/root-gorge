import 'dart:async';

import 'package:fields_api/fields_api.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

/// A Google Map that displays [Field]s.
class FieldGoogleMap extends StatefulWidget {
  /// A Google Map that displays [Field]s.
  const FieldGoogleMap({
    Key? key,
    required this.fields,
    required this.onTap,
  }) : super(key: key);

  /// The [Field]s to display on the map.
  final List<Field> fields;

  /// Called when the map is tapped.
  final void Function(LatLng) onTap;

  @override
  State<FieldGoogleMap> createState() => _FieldGoogleMapState();
}

class _FieldGoogleMapState extends State<FieldGoogleMap> {
  late GoogleMapController _mapController;
  late Location _location;

  LatLng initialPosition = const LatLng(40.6143552, -104.9526272);

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _location = Location();
    _getUserLocation();
  }

  @override
  void initState() {
    print('new map');
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final currentLocation = await _location.getLocation();

    await _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      mapType: MapType.satellite,
      onTap: widget.onTap,
      initialCameraPosition: CameraPosition(
        zoom: 16,
        target: initialPosition,
      ),
      polygons: _buildPolygons(widget.fields),
    );
  }
}

Set<Polygon> _buildPolygons(List<Field> fields) {
  return fields.map((field) {
    return Polygon(
      points: [
        ...field.mapPoints.map(
          (point) => LatLng(point.latitude, point.longitude),
        ),
      ],
      strokeColor: Colors.grey,
      strokeWidth: 2,
      fillColor: Colors.grey.withOpacity(0.5),
      polygonId: PolygonId(field.id),
    );
  }).toSet();
}
