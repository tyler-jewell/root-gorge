part of 'edit_field_bloc.dart';

enum EditFieldStatus { initial, loading, success, failure }

class EditFieldState extends Equatable {
  const EditFieldState({
    this.status = EditFieldStatus.initial,
    this.mapPoints = const <MarkerLatLng>[],
    this.cropType = const CropType(),
    this.mapPointsCompleted = false,
  });

  final EditFieldStatus status;
  final List<MarkerLatLng> mapPoints;
  final CropType cropType;
  final bool mapPointsCompleted;

  EditFieldState copyWith({
    EditFieldStatus? status,
    List<MarkerLatLng>? mapPoints,
    CropType? cropType,
    bool? mapPointsCompleted,
  }) {
    return EditFieldState(
      status: status ?? this.status,
      mapPoints: mapPoints ?? this.mapPoints,
      cropType: cropType ?? this.cropType,
      mapPointsCompleted: mapPointsCompleted ?? this.mapPointsCompleted,
    );
  }

  @override
  List<Object?> get props => [
        status,
        mapPoints,
        cropType,
        mapPointsCompleted,
      ];
}
