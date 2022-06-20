import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/fields_overview/bloc/fields_overview_bloc.dart';
import 'package:root_gorge/fields_overview/widgets/field_details.dart';

class FieldsMap extends StatefulWidget {
  const FieldsMap({Key? key}) : super(key: key);

  @override
  State<FieldsMap> createState() => _FieldsMapState();
}

class _FieldsMapState extends State<FieldsMap> {
  late GoogleMapController _controller;
  final _zoomLevel = 15.0;

  void _updateMapLocation(double lat, double lng) {
    _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: _zoomLevel,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onLongPress(LatLng latLng) {}

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FieldsOverviewBloc>().state;

    return Stack(
      children: [
        GoogleMap(
          onLongPress: (_) => showBottomSheet<void>(
            constraints: const BoxConstraints(maxHeight: 300),
            context: context,
            builder: (builder) {
              return ListView(
                children: const [Text('Add new field')],
              );
            },
          ),
          onMapCreated: _onMapCreated,
          mapToolbarEnabled: false,
          mapType: MapType.satellite,
          initialCameraPosition: CameraPosition(
            zoom: _zoomLevel,
            target: LatLng(
              state.userLatitude,
              state.userLongitude,
            ),
          ),
        ),
        const CircleAvatar(
          child: Icon(Icons.near_me),
        )
      ],
    );
  }
}
