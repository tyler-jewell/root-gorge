import 'package:fields_api/fields_api.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FieldsMap extends StatelessWidget {
  const FieldsMap({
    Key? key,
    required this.fields,
    required this.onTap,
  }) : super(key: key);

  final List<Field> fields;
  final void Function(LatLng) onTap;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onTap: (latLng) => onTap,
      initialCameraPosition: const CameraPosition(
        zoom: 16,
        target: LatLng(40.51280238950735, -104.95310938820711),
      ),
      polygons: {
        Polygon(
          points: [
            ...fields.first.mapPoints.map(
              (point) => LatLng(point.latitude, point.longitude),
            ),
          ],
          strokeColor: Colors.red,
          strokeWidth: 2,
          fillColor: Colors.red.withOpacity(0.5),
          polygonId: const PolygonId('A'),
        )
      },
    );
  }
}
