// // ignore_for_file: constant_identifier_names
// import 'package:equatable/equatable.dart';
// import 'package:fields_api/fields_api.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'field.g.dart';

// /// Type of crops that can be planted in the field
// enum CropType {
//   /// Wheat
//   @JsonValue('wheat')
//   Wheat,

//   /// Corn
//   @JsonValue('corn')
//   Corn,

//   /// Soybeans
//   @JsonValue('soybeans')
//   Soybeans,

//   /// Non-GMO
//   @JsonValue('gmo')
//   GMO,

//   /// Organic
//   @JsonValue('organic')
//   Organic,

//   /// Other
//   @JsonValue('other')
//   Other
// }

// /// Herbicide used on field
// enum Herbicide {
//   /// Dicamba (Xtend soybean)
//   @JsonValue('dicamba')
//   Dicamba,

//   /// Enlist soybean (2,4-D)
//   @JsonValue('enlist')
//   Enlist,

//   /// Roundup
//   @JsonValue('roundup')
//   Roundup,

//   /// Other, unknown
//   @JsonValue('other')
//   Other
// }

// /// A class representing latitude and longitude coordinates.
// ///
// /// This class is immutable.
// /// Used for Google Map markers.
// @JsonSerializable(explicitToJson: true)
// class MarkerLatLng extends Equatable {
//   /// [MarkerLatLng] constructor.
//   const MarkerLatLng(this.latitude, this.longitude);

//   /// Deserializes the given [JsonMap] into a [MarkerLatLng].
//   factory MarkerLatLng.fromJson(Map<String, double> json) =>
//       _$MarkerLatLngFromJson(json);

//   /// Converts this [MarkerLatLng] into a [JsonMap].
//   Map<String, dynamic> toJson() => _$MarkerLatLngToJson(this);

//   /// The [latitude] of this location.
//   final double latitude;

//   /// The [longitude] of this location.
//   final double longitude;

//   @override
//   String toString() {
//     return 'LatLng{lat: $latitude, lng: $longitude}';
//   }

//   @override
//   List<Object?> get props => [latitude, longitude];
// }

// /// {@template field}
// /// A single field item.
// ///
// /// Contains a set of list of [mapPoints], [cropType] and [id]
// ///
// /// {@endtemplate}
// @JsonSerializable(explicitToJson: true)
// class Field extends Equatable {
//   /// {@macro field}
//   const Field({
//     String? id,
//     required this.mapPoints,
//     required this.cropType,
//     required this.herbicide,
//   }) : id = id ?? '';

//   /// Deserializes the given [JsonMap] into a [Field].
//   factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

//   /// Converts this [Field] into a [JsonMap].
//   Map<String, dynamic> toJson() => _$FieldToJson(this);

//   /// The unique identifier of the field.
//   ///
//   /// Cannot be empty.
//   final String? id;

//   /// The map [MarkerLatLng] points of the field.
//   ///
//   /// Defaults to empty list of [MarkerLatLng]s
//   final List<MarkerLatLng> mapPoints;

//   /// The type of crop.
//   ///
//   /// Defaults to [CropType.Other].
//   @JsonKey(unknownEnumValue: CropType.Other)
//   final CropType cropType;

//   /// The brand or type of herbicide being used in field.
//   ///
//   /// Defaults to [Herbicide.Other].
//   @JsonKey(unknownEnumValue: Herbicide.Other)
//   final Herbicide herbicide;

//   /// Returns a copy of this field with the given values updated.
//   ///
//   /// {@macro field}

//   Field copyWith({
//     String? id,
//     List<MarkerLatLng>? mapPoints,
//     CropType? cropType,
//     Herbicide? herbicide,
//   }) {
//     return Field(
//       id: id ?? this.id,
//       mapPoints: mapPoints ?? this.mapPoints,
//       cropType: cropType ?? this.cropType,
//       herbicide: herbicide ?? this.herbicide,
//     );
//   }

//   @override
//   List<Object> get props => [mapPoints, cropType, herbicide];
// }
