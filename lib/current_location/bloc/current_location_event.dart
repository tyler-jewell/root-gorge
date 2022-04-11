part of 'current_location_bloc.dart';

abstract class CurrentLocationEvent extends Equatable {
  const CurrentLocationEvent();
  @override
  List<Object> get props => [];
}

class UserLocationRequested extends CurrentLocationEvent {
  const UserLocationRequested();
}
