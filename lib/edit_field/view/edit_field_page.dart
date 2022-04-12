import 'package:field_google_map/field_google_map.dart';
import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/edit_crop_type/view/edit_crop_type_page.dart';
import 'package:root_gorge/edit_field/bloc/edit_field_bloc.dart';

const List<CropType> cropTypes = [
  CropType(name: 'Dicamba'),
  CropType(name: 'Enlist'),
  CropType(name: 'Roundup'),
  CropType(name: 'Non-GMO'),
  CropType(name: 'Organic'),
];

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
    final bloc = context.watch<EditFieldBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.state.status.toString()),
      ),
      body: Column(
        children: [
          Expanded(
            child: FieldGoogleMap(
              onTap: (latLng) {
                final mapPoints = [
                  ...bloc.state.mapPoints,
                  MarkerLatLng(latLng.latitude, latLng.longitude)
                ];
                context
                    .read<EditFieldBloc>()
                    .add(EditFieldPointsChanged(mapPoints));
              },
              fields: [
                Field(
                  mapPoints: bloc.state.mapPoints,
                  cropType: bloc.state.cropType,
                )
              ],
            ),
          ),
          if (bloc.state.mapPointsCompleted)
            const _EditCropType()
          else
            const _EditFieldPoints()
        ],
      ),
    );
  }
}

class _DefineCropType extends StatelessWidget {
  const _DefineCropType({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter Crop Type Name',
            ),
          ),
          const SizedBox(height: 12),
          const Text('Select crop color'),
          const SizedBox(height: 12),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Next: Select color'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EditFieldPoints extends StatelessWidget {
  const _EditFieldPoints({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Define field boundaries by tapping points on the map',
            softWrap: true,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            child: const Text('Next: Define crop type'),
            onPressed: () => context
                .read<EditFieldBloc>()
                .add(const EditFieldPointsCompleted()),
          ),
        ],
      ),
    );
  }
}

class _EditCropType extends StatelessWidget {
  const _EditCropType({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EditFieldBloc>();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Select crop type',
            style: Theme.of(context).textTheme.headline6,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 10),
          ),
          SingleChildScrollView(
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              children: cropTypes
                  .map(
                    (e) => ChoiceChip(
                      onSelected: (_) => bloc.add(EditFieldCropTypeChanged(e)),
                      label: Text(e.name),
                      selected: e == bloc.state.cropType,
                    ),
                  )
                  .toList()
                ..add(
                  ChoiceChip(
                    selected: false,
                    onSelected: (_) => Navigator.of(context).push(
                      EditCropTypePage.route(),
                    ),
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.add),
                        Text('Add Crop Type'),
                      ],
                    ),
                  ),
                ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 10),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => bloc.add(EditFieldSubmitted()),
                  child: const Text('Save field'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
