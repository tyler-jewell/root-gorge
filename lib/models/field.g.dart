// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Field _$$_FieldFromJson(Map<String, dynamic> json) => _$_Field(
      id: json['id'] as String,
      cropType: CropType.fromJson(json['cropType'] as Map<String, dynamic>),
      herbicide: Herbicide.fromJson(json['herbicide'] as Map<String, dynamic>),
      mapPoints: (json['mapPoints'] as List<dynamic>)
          .map((e) => Geo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_FieldToJson(_$_Field instance) => <String, dynamic>{
      'id': instance.id,
      'cropType': instance.cropType,
      'herbicide': instance.herbicide,
      'mapPoints': instance.mapPoints,
    };
