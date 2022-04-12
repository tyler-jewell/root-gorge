import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:root_gorge/edit_crop_type/bloc/edit_crop_type_bloc.dart';

class EditCropTypePage extends StatefulWidget {
  const EditCropTypePage({Key? key}) : super(key: key);

  static Route<void> route({CropType? initialCropType}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditCropTypeBloc(
          fieldsRepository: context.read<FieldsRepository>(),
        ),
        child: const EditCropTypePage(),
      ),
    );
  }

  @override
  State<EditCropTypePage> createState() => _EditCropTypePageState();
}

class _EditCropTypePageState extends State<EditCropTypePage> {
  bool pickingColor = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EditCropTypeBloc>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: pickingColor
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pick a color for the new crop type',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: BlockPicker(
                      useInShowDialog: false,
                      pickerColor: bloc.state.cropTypeColor ?? Colors.green,
                      onColorChanged: (color) =>
                          bloc.add(EditCropTypeColorChanged(color)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () => bloc.add(EditCropTypeSubmitted()),
                        child: const Text('Save crop type'),
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter a name for the new crop type',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: TextFormField(
                      onFieldSubmitted: (_) {
                        setState(() {
                          pickingColor = true;
                        });
                      },
                      decoration: InputDecoration(
                        hintText:
                            bloc.state.cropTypeName == '' ? 'Roundup' : '',
                      ),
                      keyboardType: TextInputType.text,
                      initialValue: bloc.state.cropTypeName,
                      onChanged: (value) =>
                          bloc.add(EditCropTypeNameChanged(value)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pickingColor = true;
                          });
                        },
                        child: const Text('Next: Pick color'),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
