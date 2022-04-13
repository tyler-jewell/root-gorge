// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkerLatLng _$MarkerLatLngFromJson(Map<String, dynamic> json) => MarkerLatLng(
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$MarkerLatLngToJson(MarkerLatLng instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      id: json['id'] as String?,
      mapPoints: (json['mapPoints'] as List<dynamic>)
          .map((e) => MarkerLatLng.fromJson((e as Map<String, dynamic>).map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              )))
          .toList(),
      cropType: $enumDecode(_$CropTypeEnumMap, json['cropType'],
          unknownValue: CropType.other),
      herbicide: $enumDecode(_$HerbicideEnumMap, json['herbicide'],
          unknownValue: Herbicide.other),
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'id': instance.id,
      'mapPoints': instance.mapPoints.map((e) => e.toJson()).toList(),
      'cropType': _$CropTypeEnumMap[instance.cropType],
      'herbicide': _$HerbicideEnumMap[instance.herbicide],
    };

const _$CropTypeEnumMap = {
  CropType.wheat: 'wheat',
  CropType.corn: 'corn',
  CropType.soybeans: 'soybeans',
  CropType.nonGmo: 'gmo',
  CropType.organic: 'organic',
  CropType.other: 'other',
};

const _$HerbicideEnumMap = {
  Herbicide.dicamba: 'dicamba',
  Herbicide.enlist: 'enlist',
  Herbicide.roundup: 'roundup',
  Herbicide.other: 'other',
};
