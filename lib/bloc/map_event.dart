part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class AddButtonClicked extends MapEvent {}

class MapSubscriptionRequested extends MapEvent {}

class AddFieldButtonClicked extends MapEvent {
  @override
  String toString() => 'AddFieldButtonClicked';
}

class CompleteAddField extends MapEvent {
  @override
  String toString() => 'CompleteAddField';
}
