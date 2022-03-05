import 'package:equatable/equatable.dart';
import 'package:fields_api/fields_api.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

/// A class representing latitude and longitude coordinates.
///
/// This class is immutable.
/// Used for Google Map markers.
class MarkerLatLng extends Equatable {
  /// [MarkerLatLng] constructor.
  const MarkerLatLng(this.latitude, this.longitude);

  /// Returns a new [MarkerLatLng] object from a [JsonMap].
  MarkerLatLng.fromJson(JsonMap json)
      : latitude = json['latitude'] as double,
        longitude = json['longitude'] as double;

  /// The [latitude] of this location.
  final double latitude;

  /// The [longitude] of this location.
  final double longitude;

  @override
  String toString() {
    return 'LatLng{lat: $latitude, lng: $longitude}';
  }

  /// Returns a new [MarkerLatLng] object
  /// with the [latitude] and [longitude] values
  JsonMap toJson() => <String, double>{
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  List<Object?> get props => [latitude, longitude];
}

/// {@template field}
/// A single field item.
///
/// Contains a set of list of [mapPoints], [beanType] and [id]
///
/// {@endtemplate}
@immutable
class Field extends Equatable {
  /// {@macro field}
  Field({
    String? id,
    required this.mapPoints,
    this.beanType = '',
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// Deserializes the given [JsonMap] into a [Field].
  Field.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        mapPoints = (json['mapPoints'] as List<dynamic>)
            .map((dynamic e) => MarkerLatLng.fromJson(e as JsonMap))
            .toList(),
        beanType = json['beanType'] as String;

  /// Converts this [Field] into a [JsonMap].
  JsonMap toJson() => <String, dynamic>{
        'id': id,
        'mapPoints': mapPoints.map((e) => e.toJson()).toList(),
        'beanType': beanType,
      };

  /// The unique identifier of the field.
  ///
  /// Cannot be empty.
  final String id;

  /// The geo fire points for the field
  ///
  /// Defaults to empty list of [MarkerLatLng]s
  final List<MarkerLatLng> mapPoints;

  /// The type of bean field.
  ///
  /// Defaults to an empty string.
  final String beanType;

  /// Returns a copy of this field with the given values updated.
  ///
  /// {@macro field}

  Field copyWith({
    String? id,
    List<MarkerLatLng>? mapPoints,
    String? beanType,
  }) {
    return Field(
      id: id ?? this.id,
      mapPoints: mapPoints ?? this.mapPoints,
      beanType: beanType ?? this.beanType,
    );
  }

  @override
  List<Object> get props => [id, mapPoints, beanType];
}
