part of 'edit_field_bloc.dart';

enum EditFieldStatus { initial, loading, success, failure }

extension EditFieldStatusX on EditFieldStatus {
  bool get isLoadingOrSuccess => [
        EditFieldStatus.loading,
        EditFieldStatus.success,
      ].contains(this);
}

class EditFieldState extends Equatable {
  const EditFieldState({
    this.status = EditFieldStatus.initial,
    this.initialField,
    this.mapPoints = const <MarkerLatLng>[],
    this.beanType = '',
  });

  final EditFieldStatus status;
  final Field? initialField;
  final List<MarkerLatLng> mapPoints;
  final String beanType;

  bool get isNewField => initialField == null;

  EditFieldState copyWith({
    EditFieldStatus? status,
    Field? initialField,
    List<MarkerLatLng>? mapPoints,
    String? beanType,
  }) {
    return EditFieldState(
      status: status ?? this.status,
      initialField: initialField ?? this.initialField,
      mapPoints: mapPoints ?? this.mapPoints,
      beanType: beanType ?? this.beanType,
    );
  }

  @override
  List<Object?> get props => [status, initialField, mapPoints, beanType];
}
