part of 'add_field_bloc.dart';

enum AddFieldStatus { initial, loading, success, failure }

class AddFieldState extends Equatable {
  const AddFieldState({
    this.status = AddFieldStatus.initial,
    this.mapPoints = const <MarkerLatLng>[],
    this.beanType = '',
  });

  final AddFieldStatus status;
  final List<MarkerLatLng> mapPoints;
  final String beanType;

  AddFieldState copyWith({
    AddFieldStatus? status,
    List<MarkerLatLng>? mapPoints,
    String? beanType,
  }) {
    return AddFieldState(
      status: status ?? this.status,
      mapPoints: mapPoints ?? this.mapPoints,
      beanType: beanType ?? this.beanType,
    );
  }

  @override
  List<Object?> get props => [status, mapPoints, beanType];
}
