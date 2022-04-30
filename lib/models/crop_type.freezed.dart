// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'crop_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CropType _$CropTypeFromJson(Map<String, dynamic> json) {
  return _CropType.fromJson(json);
}

/// @nodoc
mixin _$CropType {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CropTypeCopyWith<CropType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CropTypeCopyWith<$Res> {
  factory $CropTypeCopyWith(CropType value, $Res Function(CropType) then) =
      _$CropTypeCopyWithImpl<$Res>;
  $Res call({String name, String description});
}

/// @nodoc
class _$CropTypeCopyWithImpl<$Res> implements $CropTypeCopyWith<$Res> {
  _$CropTypeCopyWithImpl(this._value, this._then);

  final CropType _value;
  // ignore: unused_field
  final $Res Function(CropType) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CropTypeCopyWith<$Res> implements $CropTypeCopyWith<$Res> {
  factory _$CropTypeCopyWith(_CropType value, $Res Function(_CropType) then) =
      __$CropTypeCopyWithImpl<$Res>;
  @override
  $Res call({String name, String description});
}

/// @nodoc
class __$CropTypeCopyWithImpl<$Res> extends _$CropTypeCopyWithImpl<$Res>
    implements _$CropTypeCopyWith<$Res> {
  __$CropTypeCopyWithImpl(_CropType _value, $Res Function(_CropType) _then)
      : super(_value, (v) => _then(v as _CropType));

  @override
  _CropType get _value => super._value as _CropType;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_CropType(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CropType implements _CropType {
  const _$_CropType({this.name = 'Other', this.description = ''});

  factory _$_CropType.fromJson(Map<String, dynamic> json) =>
      _$$_CropTypeFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'CropType(name: $name, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CropType &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$CropTypeCopyWith<_CropType> get copyWith =>
      __$CropTypeCopyWithImpl<_CropType>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CropTypeToJson(this);
  }
}

abstract class _CropType implements CropType {
  const factory _CropType({final String name, final String description}) =
      _$_CropType;

  factory _CropType.fromJson(Map<String, dynamic> json) = _$_CropType.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CropTypeCopyWith<_CropType> get copyWith =>
      throw _privateConstructorUsedError;
}
