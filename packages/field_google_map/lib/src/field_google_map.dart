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
  final Completer<GoogleMapController> _controller = Completer();

  LatLng initialPosition = const LatLng(40.5143552, -104.9526272);

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final controller = await _controller.future;
    final location = Location();
    final currentLocation = await location.getLocation();

    await controller.animateCamera(
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
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _controller.complete,
          mapType: MapType.satellite,
          onTap: widget.onTap,
          initialCameraPosition: CameraPosition(
            zoom: 16,
            target: initialPosition,
          ),
          polygons: _buildPolygons(widget.fields),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: _getUserLocation,
            child: const Icon(
              Icons.my_location,
              color: Colors.black,
            ),
          ),
        ),
      ],
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
