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
}
