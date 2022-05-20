import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_gorge/edit_field/view/edit_field_page.dart';
import 'package:root_gorge/models/crop_type.dart';
import 'package:root_gorge/models/field.dart';
import 'package:root_gorge/models/herbicide.dart';

class FieldDetails extends StatelessWidget {
  const FieldDetails({
    Key? key,
    required this.field,
    required this.cropType,
    required this.herbicide,
  }) : super(key: key);

  final Field field;
  final CropType cropType;
  final Herbicide herbicide;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'A Field Name',
              style: GoogleFonts.openSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  EditFieldPage.route(initialField: field),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Field Details',
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Crop Type: ${cropType.name}'),
            const SizedBox(height: 5),
            Text('Herbicide: ${herbicide.name}'),
          ],
        )
      ],
    );
  }
}
