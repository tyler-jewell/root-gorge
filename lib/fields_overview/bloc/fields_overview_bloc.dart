import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:root_gorge/models/crop_type.dart';
import 'package:root_gorge/models/field.dart';
import 'package:root_gorge/models/herbicide.dart';
import 'package:root_gorge/repository/fields_repository.dart';

part 'fields_overview_event.dart';
part 'fields_overview_state.dart';

class FieldsOverviewBloc
    extends Bloc<FieldsOverviewEvent, FieldsOverviewState> {
  FieldsOverviewBloc({
    required FieldsRepository fieldsRepository,
  })  : _fieldsRepository = fieldsRepository,
        super(const FieldsOverviewState()) {
    on<FieldSubscriptionRequested>(_onFieldSubscriptionRequested);
  }

  final FieldsRepository _fieldsRepository;

  Future<void> _onFieldSubscriptionRequested(
    FieldSubscriptionRequested event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: FieldsOverviewStatus.loading));

    final fields = await _fieldsRepository.getFields();

    final cropTypes = await _fieldsRepository.getCropTypes();

    final herbicides = await _fieldsRepository.getHerbicides();

    emit(
      state.copyWith(
        status: FieldsOverviewStatus.success,
        fields: fields,
        cropTypes: cropTypes,
        herbicides: herbicides,
      ),
    );
  }
}
