import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:root_gorge/fields_overview/widgets/field_details.dart';
import 'package:root_gorge/models/field.dart';

class FieldsMap extends StatefulWidget {
  const FieldsMap({Key? key, required this.fields}) : super(key: key);

  final List<Field> fields;

  @override
  State<FieldsMap> createState() => _FieldsMapState();
}

class _FieldsMapState extends State<FieldsMap> {
  late GoogleMapController _mapController;
  late Location _location;
  LatLng initialPosition = const LatLng(40.6143552, -104.9526272);

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _location = Location();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final currentLocation = await _location.getLocation();

    initialPosition = LatLng(
      currentLocation.latitude!,
      currentLocation.longitude!,
    );

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
      mapToolbarEnabled: false,
      onMapCreated: _onMapCreated,
      mapType: MapType.satellite,
      initialCameraPosition: CameraPosition(
        zoom: 16,
        target: initialPosition,
      ),
      polygons: widget.fields
          .map(
            (field) => Polygon(
              onTap: () => showModalBottomSheet<void>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                builder: (BuildContext context) {
                  return FieldDetails(field: field);
                },
              ),
              polygonId: PolygonId(field.id),
              points: field.mapPoints
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList(),
              fillColor: Colors.green.withOpacity(0.3),
              strokeColor: Colors.green,
              strokeWidth: 2,
            ),
          )
          .toSet(),
    );
  }
}
