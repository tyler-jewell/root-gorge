part of 'fields_overview_bloc.dart';

abstract class FieldsOverviewEvent extends Equatable {
  const FieldsOverviewEvent();

  @override
  List<Object> get props => [];
}

class FieldsOverviewSubscriptionRequested extends FieldsOverviewEvent {
  const FieldsOverviewSubscriptionRequested();
}

class FieldsOverviewFieldSaved extends FieldsOverviewEvent {
  const FieldsOverviewFieldSaved(this.field);

  final Field field;

  @override
  List<Object> get props => [field];
}

class FieldsOverviewFieldDeleted extends FieldsOverviewEvent {
  const FieldsOverviewFieldDeleted(this.field);

  final Field field;

  @override
  List<Object> get props => [field];
}

class FieldsOverviewToggleAllRequested extends FieldsOverviewEvent {
  const FieldsOverviewToggleAllRequested();
}

class FieldsOverviewClearCompletedRequested extends FieldsOverviewEvent {
  const FieldsOverviewClearCompletedRequested();
}
