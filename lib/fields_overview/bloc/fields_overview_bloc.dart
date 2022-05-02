import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:root_gorge/models/field.dart';
import 'package:root_gorge/repository/fields_repository.dart';

part 'fields_overview_event.dart';
part 'fields_overview_state.dart';

class FieldsOverviewBloc
    extends Bloc<FieldsOverviewEvent, FieldsOverviewState> {
  FieldsOverviewBloc({
    required FieldsRepository fieldsRepository,
  })  : _fieldsRepository = fieldsRepository,
        super(const FieldsOverviewState()) {
    on<FieldsOverviewSubscriptionRequested>(_onSubscriptionRequested);
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
      onError: (e, s) {
        print(e);
        print(s.toString());
        return state.copyWith(
          status: () => FieldsOverviewStatus.failure,
        );
      },
    );
  }
}
