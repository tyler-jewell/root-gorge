part of 'edit_field_bloc.dart';

enum EditFieldStatus { initial, loading, success, failure }

class EditFieldState extends Equatable {
  const EditFieldState({
    this.status = EditFieldStatus.initial,
    this.mapPoints = const <MarkerLatLng>[],
    this.beanType = '',
  });

  final EditFieldStatus status;
  final List<MarkerLatLng> mapPoints;
  final String beanType;

  EditFieldState copyWith({
    EditFieldStatus? status,
    List<MarkerLatLng>? mapPoints,
    String? beanType,
  }) {
    return EditFieldState(
      status: status ?? this.status,
      mapPoints: mapPoints ?? this.mapPoints,
      beanType: beanType ?? this.beanType,
    );
  }

  @override
  List<Object?> get props => [status, mapPoints, beanType];
}
