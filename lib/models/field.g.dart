// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Field _$$_FieldFromJson(Map<String, dynamic> json) => _$_Field(
      id: json['id'] as String? ?? '',
      cropTypeId: json['cropTypeId'] as String,
      herbicideId: json['herbicideId'] as String,
      mapPoints: (json['mapPoints'] as List<dynamic>)
          .map((e) => Geo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_FieldToJson(_$_Field instance) => <String, dynamic>{
      'id': instance.id,
      'cropTypeId': instance.cropTypeId,
      'herbicideId': instance.herbicideId,
      'mapPoints': instance.mapPoints,
    };
