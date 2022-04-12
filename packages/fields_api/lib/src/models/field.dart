import 'package:equatable/equatable.dart';
import 'package:fields_api/fields_api.dart';
import 'package:flutter/material.dart';
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
/// Contains a set of list of [mapPoints], [cropType] and [id]
///
/// {@endtemplate}
@immutable
class Field extends Equatable {
  /// {@macro field}
  Field({
    String? id,
    required this.mapPoints,
    required this.cropType,
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
        cropType = CropType.fromJson(json['cropType'] as Map<String, dynamic>);

  /// Converts this [Field] into a [JsonMap].
  JsonMap toJson() => <String, dynamic>{
        'id': id,
        'mapPoints': mapPoints.map((e) => e.toJson()).toList(),
        'cropType': cropType.toJson(),
      };

  /// The unique identifier of the field.
  ///
  /// Cannot be empty.
  final String id;

  /// The geo fire points for the field
  ///
  /// Defaults to empty list of [MarkerLatLng]s
  final List<MarkerLatLng> mapPoints;

  /// The type of crop.
  ///
  /// Defaults to an empty string.
  final CropType cropType;

  /// Returns a copy of this field with the given values updated.
  ///
  /// {@macro field}

  Field copyWith({
    String? id,
    List<MarkerLatLng>? mapPoints,
    CropType? cropType,
  }) {
    return Field(
      id: id ?? this.id,
      mapPoints: mapPoints ?? this.mapPoints,
      cropType: cropType ?? this.cropType,
    );
  }

  @override
  List<Object> get props => [id, mapPoints, cropType];
}

/// {@template field}
/// A single crop type
///
/// Contains a [name]
///
/// {@endtemplate}
@immutable
class CropType extends Equatable {
  /// {@macro field}
  const CropType({
    this.name = 'unknown',
    this.labelColor = const Color.fromARGB(255, 78, 157, 90),
  });

  /// Deserializes the given [JsonMap] into a [CropType].
  CropType.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        labelColor = Color(json['labelColor'] as int);

  /// Converts this [CropType] into a [JsonMap].
  JsonMap toJson() => <String, dynamic>{
        'name': name,
        'labelColor': labelColor.value,
      };

  /// Name of the crop
  final String name;

  /// Label color of the crop on the map
  final Color labelColor;

  @override
  List<Object> get props => [name, labelColor];
}
