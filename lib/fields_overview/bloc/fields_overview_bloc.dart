import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
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
    on<UserLocationRequested>(_onUserLocationRequested);
    on<EditFieldRequested>(_onEditFieldRequested);
    on<EditFieldSubmitted>(_onEditFieldSubmitted);
  }

  final FieldsRepository _fieldsRepository;

  Future<void> _onUserLocationRequested(
    UserLocationRequested event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    await emit.forEach<Position>(
      _fieldsRepository.getUserLocation(),
      onData: (pos) => state.copyWith(
        userLatitude: pos.latitude,
        userLongitude: pos.longitude,
      ),
      onError: (_, __) => state.copyWith(status: FieldsOverviewStatus.failure),
    );
  }

  Future<void> _onEditFieldRequested(
    EditFieldRequested event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    emit(state.copyWith(editingField: true));
  }

  Future<void> _onEditFieldSubmitted(
    EditFieldSubmitted event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    emit(state.copyWith(editingField: false));
  }

  Future<void> _onFieldSubscriptionRequested(
    FieldSubscriptionRequested event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: FieldsOverviewStatus.loading));

    final cropTypes = _fieldsRepository.getCropTypes();
    final herbicides = _fieldsRepository.getHerbicides();

    await emit.forEach<List<Field>>(
      _fieldsRepository.getFields(),
      onData: (fields) => state.copyWith(
        status: FieldsOverviewStatus.success,
        fields: fields,
        cropTypes: cropTypes,
        herbicides: herbicides,
      ),
      onError: (_, __) => state.copyWith(status: FieldsOverviewStatus.failure),
    );
  }
}
