import 'package:freezed_annotation/freezed_annotation.dart';

part 'herbicide.freezed.dart';
part 'herbicide.g.dart';

@freezed
class Herbicide with _$Herbicide {
  const factory Herbicide({
    @Default('Other') String name,
    @Default('') String description,
  }) = _Herbicide;

  factory Herbicide.fromJson(Map<String, Object?> json) =>
      _$HerbicideFromJson(json);
}
