import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/fields_overview/bloc/fields_overview_bloc.dart';
import 'package:root_gorge/fields_overview/widgets/field_details.dart';

class FieldsMap extends StatelessWidget {
  const FieldsMap({
    Key? key,
    required this.editing,
  }) : super(key: key);

  final bool editing;

  @override
  Widget build(BuildContext context) {
    final state = context.read<FieldsOverviewBloc>().state;
    return GoogleMap(
      mapToolbarEnabled: false,
      mapType: MapType.satellite,
      initialCameraPosition: CameraPosition(
        zoom: 14,
        target: LatLng(
          state.userLatitude,
          state.userLongitude,
        ),
      ),
      polygons: editing
          ? {}
          : state.fields
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
                      return FieldDetails(
                        field: field,
                        cropType: state.cropTypeFromId(field.cropTypeId),
                        herbicide: state.herbicideFromId(field.herbicideId),
                      );
                    },
                  ),
                  polygonId: PolygonId(field.id),
                  points: field.mapPoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                  fillColor: Color(state.cropTypeFromId(field.cropTypeId).color)
                      .withOpacity(0.3),
                  strokeColor:
                      Color(state.cropTypeFromId(field.cropTypeId).color),
                  strokeWidth: 2,
                ),
              )
              .toSet(),
    );
  }
}
