import 'package:cloud_firestore/cloud_firestore.dart';
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
          coordinates: json['coordinates']! as List<GeoPoint>,
        );

  /// The id of the marker
  ///
  /// Cannot be empty.
  final String id;

  /// The coordinates of the marker.
  ///
  /// Cannot be empty.
  final List<GeoPoint> coordinates;

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
    required List<GeoPoint> coordinates,
  }) {
    return Marker(
      id: id,
      coordinates: coordinates,
    );
  }
}
