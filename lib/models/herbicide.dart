import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'herbicide.freezed.dart';
part 'herbicide.g.dart';

@freezed
class Herbicide with _$Herbicide {
  const factory Herbicide({
    @Default('') String id,
    @Default('Other') String name,
    @Default('') String description,
  }) = _Herbicide;

  factory Herbicide.fromDocument(DocumentSnapshot document) {
    if (document.data() == null) {
      return const Herbicide();
    }
    return Herbicide.fromJson(document.data()! as Map<String, Object?>)
        .copyWith(
      id: document.id,
    );
  }

  factory Herbicide.fromJson(Map<String, Object?> json) =>
      _$HerbicideFromJson(json);
}
