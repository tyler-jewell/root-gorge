import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:root_gorge/edit_field/view/view.dart';
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
    on<CropTypeSubscriptionRequested>(_onCropTypeSubscriptionRequested);
    on<HerbicideSubscriptionRequested>(_onHerbiceSubscriptionRequested);
  }

  final FieldsRepository _fieldsRepository;

  Future<void> _onFieldSubscriptionRequested(
    FieldSubscriptionRequested event,
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
        return state.copyWith(
          status: () => FieldsOverviewStatus.failure,
        );
      },
    );
  }

  Future<void> _onCropTypeSubscriptionRequested(
    CropTypeSubscriptionRequested event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => FieldsOverviewStatus.loading));

    await emit.forEach<List<CropType>>(
      _fieldsRepository.getCropTypes(),
      onData: (cropTypes) {
        print(cropTypes);
        return state.copyWith(
          status: () => FieldsOverviewStatus.success,
          cropTypes: () => cropTypes,
        );
      },
      onError: (e, s) {
        return state.copyWith(
          status: () => FieldsOverviewStatus.failure,
        );
      },
    );
  }

  Future<void> _onHerbiceSubscriptionRequested(
    HerbicideSubscriptionRequested event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => FieldsOverviewStatus.loading));

    await emit.forEach<List<Herbicide>>(
      _fieldsRepository.getHerbicides(),
      onData: (cropTypes) => state.copyWith(
        status: () => FieldsOverviewStatus.success,
        herbicides: () => herbicides,
      ),
      onError: (e, s) {
        return state.copyWith(
          status: () => FieldsOverviewStatus.failure,
        );
      },
    );
  }
}
