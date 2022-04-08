part of 'fields_overview_bloc.dart';

enum FieldsOverviewStatus { initial, loading, success, failure }

class FieldsOverviewState extends Equatable {
  const FieldsOverviewState({
    this.currentLocation,
    this.status = FieldsOverviewStatus.initial,
    this.fields = const [],
  });

  final LatLng? currentLocation;
  final FieldsOverviewStatus status;
  final List<Field> fields;

  FieldsOverviewState copyWith({
    LatLng? currentLocation,
    FieldsOverviewStatus Function()? status,
    List<Field> Function()? fields,
  }) {
    return FieldsOverviewState(
      currentLocation: currentLocation ?? this.currentLocation,
      status: status != null ? status() : this.status,
      fields: fields != null ? fields() : this.fields,
    );
  }

  @override
  List<Object?> get props => [status, fields, currentLocation];
}
