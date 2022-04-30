import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_gorge/edit_field/bloc/edit_field_bloc.dart';
import 'package:root_gorge/models/crop_type.dart';
import 'package:root_gorge/models/field.dart';
import 'package:root_gorge/repository/fields_repository.dart';

class EditFieldPage extends StatelessWidget {
  const EditFieldPage({Key? key}) : super(key: key);

  static Route<void> route({Field? initialField}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => EditFieldBloc(
          fieldsRepository: context.read<FieldsRepository>(),
          initialField: initialField,
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
    final state = context.watch<EditFieldBloc>().state;
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Edit Field'))),
      body: ListView(
        children: [
          Text(
            'Field type',
            style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: CropType.values
                .map(
                  (CropType cropType) => FilterChip(
                    selected: state.cropType == cropType,
                    label: Text(cropType.name),
                    onSelected: (_) {
                      context
                          .read<EditFieldBloc>()
                          .add(EditFieldCropTypeChanged(cropType));
                    },
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          Text(
            'Herbicide type',
            style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: Herbicide.values
                .map(
                  (Herbicide herbicideType) => FilterChip(
                    selected: state.herbicide == herbicideType,
                    label: Text(herbicideType.name),
                    onSelected: (_) {
                      context
                          .read<EditFieldBloc>()
                          .add(EditFieldHerbicideChanged(herbicideType));
                    },
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.6,
                      40,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    context.read<EditFieldBloc>().add(EditFieldSubmitted());
                  },
                  child: const Text('Save Field'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
