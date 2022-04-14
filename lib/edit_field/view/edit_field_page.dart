import 'package:field_google_map/field_google_map.dart';
import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/edit_field/bloc/edit_field_bloc.dart';

const List<Color> cropColors = [
  Colors.green,
  Colors.blue,
  Colors.red,
  Colors.orange,
  Colors.purple,
];

class EditFieldPage extends StatelessWidget {
  const EditFieldPage({Key? key}) : super(key: key);

  static Route<void> route({Field? initialField}) {
    print('route');
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => EditFieldBloc(
          fieldsRepository: context.read<FieldsRepository>(),
        ),
        child: const EditFieldView(),
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

class EditFieldView extends StatefulWidget {
  const EditFieldView({Key? key}) : super(key: key);

  @override
  State<EditFieldView> createState() => _EditFieldViewState();
}

class _EditFieldViewState extends State<EditFieldView> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditFieldBloc>().state;
    print('build page');

    return Scaffold(
      appBar: AppBar(
        title: Text(state.status.toString()),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.1,
            minWidth: double.infinity,
          ),
          color: Colors.white,
          child: Center(
            child: Text(
              'Tap the map to mark the boundaries of your field',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: FieldGoogleMap(
              onTap: (latLng) {
                if (state.status == EditFieldStatus.editingMapPoints) {
                  final mapPoints = [
                    ...state.mapPoints,
                    MarkerLatLng(latLng.latitude, latLng.longitude)
                  ];
                  context
                      .read<EditFieldBloc>()
                      .add(EditFieldMapPointsChanged(mapPoints));
                }
              },
              fields: [
                Field(
                  mapPoints: state.mapPoints,
                  cropType: state.cropType,
                  herbicide: state.herbicide,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
