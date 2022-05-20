import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/add_field/add_field.dart';

class AddFieldPage extends StatelessWidget {
  const AddFieldPage({Key? key}) : super(key: key);

  static Route<void> route({
    required double lat,
    required double lng,
  }) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => AddFieldBloc()
          ..add(
            AddFieldRequested(lat, lng),
          ),
        child: const AddFieldView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AddFieldView();
  }
}

class AddFieldView extends StatelessWidget {
  const AddFieldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomGesturesEnabled: context.read<AddFieldBloc>().state.panEnabled,
      mapToolbarEnabled: false,
      mapType: MapType.satellite,
      onTap: (point) => context.read<AddFieldBloc>().add(
            AddPolygonPoint(point),
          ),
      initialCameraPosition: CameraPosition(
        zoom: 16,
        target: LatLng(
          context.read<AddFieldBloc>().state.mapLatitude,
          context.read<AddFieldBloc>().state.mapLongitude,
        ),
      ),
      polygons: context.read<AddFieldBloc>().state.polygons,
    );
  }
}
