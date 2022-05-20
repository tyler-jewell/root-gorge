part of 'add_field_bloc.dart';

enum AddFieldStatus { initial, loading, success, failure }

class AddFieldState extends Equatable {
  const AddFieldState({
    this.status = AddFieldStatus.initial,
    this.panEnabled = true,
    this.polygons = const {},
    this.mapLatitude = 0.0,
    this.mapLongitude = 0.0,
  });

  final AddFieldStatus status;
  final bool panEnabled;
  final Set<Polygon> polygons;
  final double mapLatitude;
  final double mapLongitude;

  AddFieldState copyWith({
    AddFieldStatus? status,
    bool? panEnabled,
    Set<Polygon>? polygons,
    double? mapLatitude,
    double? mapLongitude,
  }) {
    return AddFieldState(
      status: status ?? this.status,
      panEnabled: panEnabled ?? this.panEnabled,
      polygons: polygons ?? this.polygons,
      mapLatitude: mapLatitude ?? this.mapLatitude,
      mapLongitude: mapLongitude ?? this.mapLongitude,
    );
  }

  @override
  List<Object?> get props => [
        status,
        panEnabled,
        polygons,
        mapLatitude,
        mapLongitude,
      ];
}
