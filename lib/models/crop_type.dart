import 'package:freezed_annotation/freezed_annotation.dart';

part 'crop_type.freezed.dart';
part 'crop_type.g.dart';

@freezed
class CropType with _$CropType {
  const factory CropType({
    @Default('Other') String name,
    @Default('') String description,
  }) = _CropType;

  factory CropType.fromJson(Map<String, Object?> json) =>
      _$CropTypeFromJson(json);
}
