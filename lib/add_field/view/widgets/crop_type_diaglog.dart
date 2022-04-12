import 'package:flutter/material.dart';

enum CropType { dicamba, enlist }

class CropTypeDialog extends StatefulWidget {
  const CropTypeDialog({Key? key}) : super(key: key);

  @override
  State<CropTypeDialog> createState() => _CropTypeDialogState();
}

class _CropTypeDialogState extends State<CropTypeDialog> {
  CropType _cropType = CropType.dicamba;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Select crop type'),
      children: [
        RadioListTile<CropType>(
          value: CropType.dicamba,
          groupValue: _cropType,
          onChanged: (value) {
            setState(() {
              _cropType = value!;
            });
          },
        ),
        RadioListTile<CropType>(
          value: CropType.enlist,
          groupValue: _cropType,
          onChanged: (value) {
            setState(() {
              _cropType = value!;
            });
          },
        ),
      ],
    );
  }
}
