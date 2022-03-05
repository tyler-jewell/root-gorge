import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fields_repository/fields_repository.dart';

part 'fields_overview_event.dart';
part 'fields_overview_state.dart';

class FieldsOverviewBloc
    extends Bloc<FieldsOverviewEvent, FieldsOverviewState> {
  FieldsOverviewBloc({
    required FieldsRepository fieldsRepository,
  })  : _fieldsRepository = fieldsRepository,
        super(const FieldsOverviewState()) {
    on<FieldsOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<FieldsOverviewFieldSaved>(_onFieldSaved);
    on<FieldsOverviewFieldDeleted>(_onFieldDeleted);
  }

  final FieldsRepository _fieldsRepository;

  Future<void> _onSubscriptionRequested(
    FieldsOverviewSubscriptionRequested event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => FieldsOverviewStatus.loading));

    await emit.forEach<List<Field>>(
      _fieldsRepository.getFields(),
      onData: (fields) => state.copyWith(
        status: () => FieldsOverviewStatus.success,
        fields: () => fields,
      ),
      onError: (_, __) => state.copyWith(
        status: () => FieldsOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onFieldSaved(
    FieldsOverviewFieldSaved event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    await _fieldsRepository.saveField(event.field);
  }

  Future<void> _onFieldDeleted(
    FieldsOverviewFieldDeleted event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    await _fieldsRepository.deleteField(event.field.id);
  }
}
