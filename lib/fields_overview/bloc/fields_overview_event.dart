part of 'fields_overview_bloc.dart';

abstract class FieldsOverviewEvent extends Equatable {
  const FieldsOverviewEvent();

  @override
  List<Object> get props => [];
}

class FieldSubscriptionRequested extends FieldsOverviewEvent {
  const FieldSubscriptionRequested();
}

class EditFieldRequested extends FieldsOverviewEvent {
  const EditFieldRequested();
}

class EditFieldSubmitted extends FieldsOverviewEvent {
  const EditFieldSubmitted();
}

class UserLocationRequested extends FieldsOverviewEvent {
  const UserLocationRequested();
}
