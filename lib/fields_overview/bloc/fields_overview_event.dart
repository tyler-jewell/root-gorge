part of 'fields_overview_bloc.dart';

abstract class FieldsOverviewEvent extends Equatable {
  const FieldsOverviewEvent();

  @override
  List<Object> get props => [];
}

class FieldSubscriptionRequested extends FieldsOverviewEvent {
  const FieldSubscriptionRequested();
}

class CropTypeSubscriptionRequested extends FieldsOverviewEvent {
  const CropTypeSubscriptionRequested();
}

class HerbicideSubscriptionRequested extends FieldsOverviewEvent {
  const HerbicideSubscriptionRequested();
}
