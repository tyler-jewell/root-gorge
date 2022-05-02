part of 'fields_overview_bloc.dart';

enum FieldsOverviewStatus { initial, loading, success, failure }

class FieldsOverviewState extends Equatable {
  const FieldsOverviewState({
    this.status = FieldsOverviewStatus.initial,
    this.fields = const [],
  });

  final FieldsOverviewStatus status;
  final List<Field> fields;

  FieldsOverviewState copyWith({
    FieldsOverviewStatus Function()? status,
    List<Field> Function()? fields,
  }) {
    return FieldsOverviewState(
      status: status != null ? status() : this.status,
      fields: fields != null ? fields() : this.fields,
    );
  }

  @override
  List<Object?> get props => [status, fields];
}

class FieldsOverviewError extends FieldsOverviewState {
  const FieldsOverviewError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
