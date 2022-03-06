import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/edit_field/bloc/edit_field_bloc.dart';
import 'package:root_gorge/edit_field/edit_field.dart';

class EditFieldPage extends StatelessWidget {
  const EditFieldPage({Key? key}) : super(key: key);

  static Route<void> route({Field? initialField}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditFieldBloc(
          fieldsRepository: context.read<FieldsRepository>(),
        ),
        child: const EditFieldPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditFieldBloc, EditFieldState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditFieldStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditFieldView(),
    );
  }
}

class EditFieldView extends StatelessWidget {
  const EditFieldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditFieldBloc bloc) => bloc.state.status);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Field'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: status == EditFieldStatus.success
            ? null
            : () => context.read<EditFieldBloc>().add(EditFieldSubmitted()),
        child: status == EditFieldStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : const Icon(Icons.check_rounded),
      ),
      body: const _GoogleMap(),
    );
  }
}

class _GoogleMap extends StatelessWidget {
  const _GoogleMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditFieldBloc>().state;

    return GoogleMap(
      onTap: (latLng) {
        print('latLng: $latLng');
        context.read<EditFieldBloc>().add(
              EditFieldMapPointsChanged(
                [
                  ...state.mapPoints,
                  MarkerLatLng(latLng.latitude, latLng.longitude)
                ],
              ),
            );
      },
      initialCameraPosition: const CameraPosition(
        zoom: 16,
        target: LatLng(40.51280238950735, -104.95310938820711),
      ),
      polygons: {
        Polygon(
          points: [
            ...state.mapPoints.map(
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
