import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crop_type.freezed.dart';
part 'crop_type.g.dart';

@freezed
class CropType with _$CropType {
  const factory CropType({
    @Default('') String id,
    @Default('Other') String name,
    @Default('') String description,
  }) = _CropType;

  factory CropType.fromDocument(DocumentSnapshot document) {
    if (document.data() == null) {
      return const CropType();
    }
    return CropType.fromJson(document.data()! as Map<String, Object?>).copyWith(
      id: document.id,
    );
  }

  factory CropType.fromJson(Map<String, Object?> json) =>
      _$CropTypeFromJson(json);
}
