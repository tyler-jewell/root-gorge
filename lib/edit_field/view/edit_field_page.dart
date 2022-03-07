import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/edit_field/bloc/edit_field_bloc.dart';
import 'package:root_gorge/edit_field/edit_field.dart';
import 'package:root_gorge/home/widgets/fields_map.dart';

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
    final state = context.watch<EditFieldBloc>().state;

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
      body: FieldsMap(
        onTap: (latLng) => _handleTap(latLng, context.read<EditFieldBloc>()),
        fields: [
          Field(
            mapPoints: state.mapPoints,
            beanType: state.beanType,
          )
        ],
      ),
    );
  }
}

void _handleTap(LatLng latLng, EditFieldBloc bloc) {
  bloc.add(
    EditFieldMapPointsChanged(
      [
        ...bloc.state.mapPoints,
        MarkerLatLng(latLng.latitude, latLng.longitude)
      ],
    ),
  );
}
