// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'herbicide.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Herbicide _$HerbicideFromJson(Map<String, dynamic> json) {
  return _Herbicide.fromJson(json);
}

/// @nodoc
mixin _$Herbicide {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HerbicideCopyWith<Herbicide> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HerbicideCopyWith<$Res> {
  factory $HerbicideCopyWith(Herbicide value, $Res Function(Herbicide) then) =
      _$HerbicideCopyWithImpl<$Res>;
  $Res call({String name, String description});
}

/// @nodoc
class _$HerbicideCopyWithImpl<$Res> implements $HerbicideCopyWith<$Res> {
  _$HerbicideCopyWithImpl(this._value, this._then);

  final Herbicide _value;
  // ignore: unused_field
  final $Res Function(Herbicide) _then;

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
abstract class _$HerbicideCopyWith<$Res> implements $HerbicideCopyWith<$Res> {
  factory _$HerbicideCopyWith(
          _Herbicide value, $Res Function(_Herbicide) then) =
      __$HerbicideCopyWithImpl<$Res>;
  @override
  $Res call({String name, String description});
}

/// @nodoc
class __$HerbicideCopyWithImpl<$Res> extends _$HerbicideCopyWithImpl<$Res>
    implements _$HerbicideCopyWith<$Res> {
  __$HerbicideCopyWithImpl(_Herbicide _value, $Res Function(_Herbicide) _then)
      : super(_value, (v) => _then(v as _Herbicide));

  @override
  _Herbicide get _value => super._value as _Herbicide;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_Herbicide(
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
class _$_Herbicide implements _Herbicide {
  const _$_Herbicide({this.name = 'Other', this.description = ''});

  factory _$_Herbicide.fromJson(Map<String, dynamic> json) =>
      _$$_HerbicideFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'Herbicide(name: $name, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Herbicide &&
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
  _$HerbicideCopyWith<_Herbicide> get copyWith =>
      __$HerbicideCopyWithImpl<_Herbicide>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HerbicideToJson(this);
  }
}

abstract class _Herbicide implements Herbicide {
  const factory _Herbicide({final String name, final String description}) =
      _$_Herbicide;

  factory _Herbicide.fromJson(Map<String, dynamic> json) =
      _$_Herbicide.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HerbicideCopyWith<_Herbicide> get copyWith =>
      throw _privateConstructorUsedError;
}
