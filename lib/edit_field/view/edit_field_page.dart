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

    return Scaffold(
      appBar: AppBar(
        title: Text(state.status.toString()),
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
          Expanded(
            flex: 3,
            child: BottomSheet(
              onClosing: () {},
              builder: (BuildContext context) {
                if (state.status == EditFieldStatus.editingMapPoints) {
                  return Column(
                    children: [
                      const Text(
                        'Tap the points around the field'
                        ' to idenify your coordinates.',
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state.status == EditFieldStatus.editingCropType) {
                  return const Text('Select the crop type.');
                } else {
                  return const Text('Select the herbicide.');
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

// class _EditFieldPoints extends StatelessWidget {
//   const _EditFieldPoints({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             'Define field boundaries by tapping points on the map',
//             softWrap: true,
//             style: Theme.of(context).textTheme.headline6,
//           ),
//           const SizedBox(height: 12),
//           ElevatedButton(
//             child: const Text('Next: Define crop type'),
//             onPressed: () => context
//                 .read<EditFieldBloc>()
//                 .add(const EditFieldPointsCompleted()),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _EditCropType extends StatelessWidget {
//   const _EditCropType({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.watch<EditFieldBloc>();
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             'Select crop type',
//             style: Theme.of(context).textTheme.headline6,
//           ),
//           ConstrainedBox(
//             constraints: const BoxConstraints(minHeight: 10),
//           ),
//           SingleChildScrollView(
//             child: Wrap(
//               runSpacing: 10,
//               spacing: 10,
//               children: cropTypes
//                   .map(
//                     (e) => ChoiceChip(
//                       onSelected: (_) =>
// bloc.add(EditFieldCropTypeChanged(e)),
//                       label: Text(e.name),
//                       selected: e == bloc.state.cropType,
//                     ),
//                   )
//                   .toList()
//                 ..add(
//                   ChoiceChip(
//                     selected: false,
//                     onSelected: (_) => Navigator.of(context).push(
//                       EditCropTypePage.route(),
//                     ),
//                     label: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: const [
//                         Icon(Icons.add),
//                         Text('Add Crop Type'),
//                       ],
//                     ),
//                   ),
//                 ),
//             ),
//           ),
//           ConstrainedBox(
//             constraints: const BoxConstraints(minHeight: 10),
//           ),
//           Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => bloc.add(EditFieldSubmitted()),
//                   child: const Text('Save field'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
