import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/home/home.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.01755830492381, -89.04235593358224),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            GoogleMap(
              mapType: MapType.satellite,
              initialCameraPosition: _kGooglePlex,
              markers: Set<Marker>.of(state.markers),
            ),
          ],
        );
      },
    );
  }
}
