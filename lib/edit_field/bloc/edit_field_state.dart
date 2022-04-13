part of 'edit_field_bloc.dart';

enum EditFieldStatus {
  editingMapPoints,
  editingCropType,
  editingHerbicide,
  loading,
  success,
  failure
}

class EditFieldState extends Equatable {
  const EditFieldState({
    this.status = EditFieldStatus.editingMapPoints,
    this.mapPoints = const <MarkerLatLng>[],
    this.cropType = CropType.other,
    this.herbicide = Herbicide.other,
  });

  final EditFieldStatus status;
  final List<MarkerLatLng> mapPoints;
  final CropType cropType;
  final Herbicide herbicide;

  EditFieldState copyWith({
    EditFieldStatus? status,
    List<MarkerLatLng>? mapPoints,
    CropType? cropType,
    Herbicide? herbicide,
  }) {
    return EditFieldState(
      status: status ?? this.status,
      mapPoints: mapPoints ?? this.mapPoints,
      cropType: cropType ?? this.cropType,
      herbicide: herbicide ?? this.herbicide,
    );
  }

  @override
  List<Object?> get props => [
        status,
        mapPoints,
        cropType,
        herbicide,
      ];
}
