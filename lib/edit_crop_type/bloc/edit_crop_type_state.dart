part of 'edit_crop_type_bloc.dart';

enum EditCropTypeStatus {
  initial,
  loading,
  success,
  failure,
}

class EditCropTypeState extends Equatable {
  const EditCropTypeState({
    this.status = EditCropTypeStatus.initial,
    this.initialCropType,
    this.cropTypeColor,
    this.cropTypeName = '',
  });

  final EditCropTypeStatus status;
  final CropType? initialCropType;
  final Color? cropTypeColor;
  final String cropTypeName;

  bool get isCropType => initialCropType == null;

  EditCropTypeState copyWith({
    EditCropTypeStatus? status,
    CropType? initialCropType,
    Color? cropTypeColor,
    String? cropTypeName,
    bool? pickingColor,
  }) {
    return EditCropTypeState(
      status: status ?? this.status,
      initialCropType: initialCropType ?? this.initialCropType,
      cropTypeColor: cropTypeColor ?? this.cropTypeColor,
      cropTypeName: cropTypeName ?? this.cropTypeName,
    );
  }

  @override
  List<Object?> get props => [
        status,
        initialCropType,
        cropTypeColor,
        cropTypeName,
      ];
}
