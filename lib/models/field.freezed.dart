// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Field _$FieldFromJson(Map<String, dynamic> json) {
  return _Field.fromJson(json);
}

/// @nodoc
mixin _$Field {
  String get id => throw _privateConstructorUsedError;
  String get cropTypeId => throw _privateConstructorUsedError;
  String get herbicideId => throw _privateConstructorUsedError;
  List<Geo> get mapPoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldCopyWith<Field> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldCopyWith<$Res> {
  factory $FieldCopyWith(Field value, $Res Function(Field) then) =
      _$FieldCopyWithImpl<$Res>;
  $Res call(
      {String id, String cropTypeId, String herbicideId, List<Geo> mapPoints});
}

/// @nodoc
class _$FieldCopyWithImpl<$Res> implements $FieldCopyWith<$Res> {
  _$FieldCopyWithImpl(this._value, this._then);

  final Field _value;
  // ignore: unused_field
  final $Res Function(Field) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? cropTypeId = freezed,
    Object? herbicideId = freezed,
    Object? mapPoints = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      cropTypeId: cropTypeId == freezed
          ? _value.cropTypeId
          : cropTypeId // ignore: cast_nullable_to_non_nullable
              as String,
      herbicideId: herbicideId == freezed
          ? _value.herbicideId
          : herbicideId // ignore: cast_nullable_to_non_nullable
              as String,
      mapPoints: mapPoints == freezed
          ? _value.mapPoints
          : mapPoints // ignore: cast_nullable_to_non_nullable
              as List<Geo>,
    ));
  }
}

/// @nodoc
abstract class _$FieldCopyWith<$Res> implements $FieldCopyWith<$Res> {
  factory _$FieldCopyWith(_Field value, $Res Function(_Field) then) =
      __$FieldCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id, String cropTypeId, String herbicideId, List<Geo> mapPoints});
}

/// @nodoc
class __$FieldCopyWithImpl<$Res> extends _$FieldCopyWithImpl<$Res>
    implements _$FieldCopyWith<$Res> {
  __$FieldCopyWithImpl(_Field _value, $Res Function(_Field) _then)
      : super(_value, (v) => _then(v as _Field));

  @override
  _Field get _value => super._value as _Field;

  @override
  $Res call({
    Object? id = freezed,
    Object? cropTypeId = freezed,
    Object? herbicideId = freezed,
    Object? mapPoints = freezed,
  }) {
    return _then(_Field(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      cropTypeId: cropTypeId == freezed
          ? _value.cropTypeId
          : cropTypeId // ignore: cast_nullable_to_non_nullable
              as String,
      herbicideId: herbicideId == freezed
          ? _value.herbicideId
          : herbicideId // ignore: cast_nullable_to_non_nullable
              as String,
      mapPoints: mapPoints == freezed
          ? _value.mapPoints
          : mapPoints // ignore: cast_nullable_to_non_nullable
              as List<Geo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Field implements _Field {
  const _$_Field(
      {this.id = '',
      required this.cropTypeId,
      required this.herbicideId,
      required final List<Geo> mapPoints})
      : _mapPoints = mapPoints;

  factory _$_Field.fromJson(Map<String, dynamic> json) =>
      _$$_FieldFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  final String cropTypeId;
  @override
  final String herbicideId;
  final List<Geo> _mapPoints;
  @override
  List<Geo> get mapPoints {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mapPoints);
  }

  @override
  String toString() {
    return 'Field(id: $id, cropTypeId: $cropTypeId, herbicideId: $herbicideId, mapPoints: $mapPoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Field &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.cropTypeId, cropTypeId) &&
            const DeepCollectionEquality()
                .equals(other.herbicideId, herbicideId) &&
            const DeepCollectionEquality().equals(other.mapPoints, mapPoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(cropTypeId),
      const DeepCollectionEquality().hash(herbicideId),
      const DeepCollectionEquality().hash(mapPoints));

  @JsonKey(ignore: true)
  @override
  _$FieldCopyWith<_Field> get copyWith =>
      __$FieldCopyWithImpl<_Field>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FieldToJson(this);
  }
}

abstract class _Field implements Field {
  const factory _Field(
      {final String id,
      required final String cropTypeId,
      required final String herbicideId,
      required final List<Geo> mapPoints}) = _$_Field;

  factory _Field.fromJson(Map<String, dynamic> json) = _$_Field.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get cropTypeId => throw _privateConstructorUsedError;
  @override
  String get herbicideId => throw _privateConstructorUsedError;
  @override
  List<Geo> get mapPoints => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FieldCopyWith<_Field> get copyWith => throw _privateConstructorUsedError;
}
