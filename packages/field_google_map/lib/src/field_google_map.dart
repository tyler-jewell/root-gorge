import 'package:fields_api/fields_api.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A Google Map that displays [Field]s.
class FieldGoogleMap extends StatelessWidget {
  /// A Google Map that displays [Field]s.
  const FieldGoogleMap({
    Key? key,
    required this.fields,
    required this.onTap,
  }) : super(key: key);

  /// The [Field]s to display on the map.
  final List<Field> fields;

  /// Called when the mapt is tapped.
  final void Function(LatLng) onTap;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onTap: onTap,
      initialCameraPosition: const CameraPosition(
        zoom: 16,
        target: LatLng(40.51280238950735, -104.95310938820711),
      ),
      polygons: _buildPolygons(fields),
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
      strokeColor: Colors.red,
      strokeWidth: 2,
      fillColor: Colors.red.withOpacity(0.5),
      polygonId: PolygonId(field.id),
    );
  }).toSet();
}
