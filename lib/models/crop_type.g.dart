// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CropType _$$_CropTypeFromJson(Map<String, dynamic> json) => _$_CropType(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Other',
      description: json['description'] as String? ?? '',
      color: json['color'] as int? ?? 0x3486E0,
    );

Map<String, dynamic> _$$_CropTypeToJson(_$_CropType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'color': instance.color,
    };
