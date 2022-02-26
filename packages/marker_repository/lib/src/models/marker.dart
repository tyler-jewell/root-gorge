import 'package:meta/meta.dart';

/// {@template todo}
/// A single marker object.
///
/// {@endtemplate}
@immutable
class Marker {
  /// [Marker] constructor.
  const Marker({
    required this.id,
    required this.coordinates,
  });

  /// Converts [Map] object into a [Marker].
  Marker.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          coordinates: json['coordinates']! as List<List<double>>,
        );

  /// The id of the marker
  ///
  /// Cannot be empty.
  final String id;

  /// The coordinates of the marker.
  ///
  /// Cannot be empty.
  final List<List<double>> coordinates;

  /// Converts this [Marker] object into a [Map].
  Map<String, Object?> toJson() {
    return {
      'coordinates': coordinates,
      'id': id,
    };
  }

  /// Returns a copy of this [Marker].
  Marker copyWith({
    required String id,
    required List<List<double>> coordinates,
  }) {
    return Marker(
      id: id,
      coordinates: coordinates,
    );
  }
}
