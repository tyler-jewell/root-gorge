part of 'current_location_bloc.dart';

enum CurrenLocationStatus { initial, loading, success, failure }

class CurrentLocationState extends Equatable {
  const CurrentLocationState({
    this.currentLocation,
    this.status = CurrenLocationStatus.initial,
  });

  final LatLng? currentLocation;
  final CurrenLocationStatus status;

  CurrentLocationState copyWith({
    LatLng? currentLocation,
    CurrenLocationStatus Function()? status,
  }) {
    return CurrentLocationState(
      currentLocation: currentLocation ?? this.currentLocation,
      status: status != null ? status() : this.status,
    );
  }

  @override
  List<Object?> get props => [status, currentLocation];
}
