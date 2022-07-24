part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FieldsRequested extends HomeEvent {
  const FieldsRequested({required this.devicePixelRatio});

  final double devicePixelRatio;

  @override
  List<Object> get props => [devicePixelRatio];
}
