part of 'fields_overview_bloc.dart';

abstract class FieldsOverviewEvent extends Equatable {
  const FieldsOverviewEvent();

  @override
  List<Object> get props => [];
}

class FieldsOverviewSubscriptionRequested extends FieldsOverviewEvent {
  const FieldsOverviewSubscriptionRequested();
}
