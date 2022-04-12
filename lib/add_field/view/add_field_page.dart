import 'package:field_google_map/field_google_map.dart';
import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/add_field/add_field.dart';
import 'package:root_gorge/add_field/bloc/add_field_bloc.dart';

class AddFieldPage extends StatelessWidget {
  const AddFieldPage({Key? key}) : super(key: key);

  static Route<void> route({Field? initialField}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => AddFieldBloc(
          fieldsRepository: context.read<FieldsRepository>(),
        ),
        child: const AddFieldPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFieldBloc, AddFieldState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == AddFieldStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const AddFieldView(),
    );
  }
}

class AddFieldView extends StatelessWidget {
  const AddFieldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((AddFieldBloc bloc) => bloc.state.status);
    final state = context.watch<AddFieldBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Field'),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: status == AddFieldStatus.success
            ? null
            : () async {
                await showDialog<void>(
                  context: context,
                  builder: (context) => dialog,
                ).then(
                  (value) => context.read<AddFieldBloc>().add(
                        AddFieldSubmitted(),
                      ),
                );
              },
        child: status == AddFieldStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : const Icon(Icons.check_rounded),
      ),
      body: FieldGoogleMap(
        key: const Key('Add-field-page-field-map'),
        onTap: (latLng) {
          final mapPoints = [
            ...state.mapPoints,
            MarkerLatLng(latLng.latitude, latLng.longitude)
          ];
          context.read<AddFieldBloc>().add(AddFieldMapPointsChanged(mapPoints));
        },
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
