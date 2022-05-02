import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:root_gorge/models/crop_type.dart';
import 'package:root_gorge/models/geo.dart';
import 'package:root_gorge/models/herbicide.dart';

part 'field.freezed.dart';
part 'field.g.dart';

@freezed
class Field with _$Field {
  const factory Field({
    required String id,
    required CropType cropType,
    required Herbicide herbicide,
    required List<Geo> mapPoints,
  }) = _Field;

  factory Field.fromJson(Map<String, Object?> json) => _$FieldFromJson(json);

  factory Field.fromDocument(DocumentSnapshot document) {
    if (document.data() == null) {
      return Field.empty();
    }
    return Field.fromJson(document.data()! as Map<String, Object?>).copyWith(
      id: document.id,
    );
  }

  factory Field.empty() {
    return const Field(
      id: '',
      cropType: CropType(),
      herbicide: Herbicide(),
      mapPoints: [],
    );
  }
}
