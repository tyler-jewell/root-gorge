import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:root_gorge/models/crop_type.dart';
import 'package:root_gorge/models/field.dart';
import 'package:root_gorge/models/herbicide.dart';
import 'package:root_gorge/repository/fields_repository.dart';
import 'package:root_gorge/repository/location_repository.dart';

part 'fields_overview_event.dart';
part 'fields_overview_state.dart';

class FieldsOverviewBloc
    extends Bloc<FieldsOverviewEvent, FieldsOverviewState> {
  FieldsOverviewBloc({
    required FieldsRepository fieldsRepository,
    required LocationRepository locationRepository,
  })  : _fieldsRepository = fieldsRepository,
        _locationRepository = locationRepository,
        super(const FieldsOverviewState()) {
    on<FieldSubscriptionRequested>(_onFieldSubscriptionRequested);
    on<EditFieldRequested>(_onEditFieldRequested);
    on<EditFieldSubmitted>(_onEditFieldSubmitted);
    on<UserLocationRequested>(_onUserLocationRequested);
  }

  final FieldsRepository _fieldsRepository;
  final LocationRepository _locationRepository;

  Future<void> _onUserLocationRequested(
    UserLocationRequested event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    final userLocation = await _locationRepository.getUserLocation();

    emit(
      state.copyWith(
        userLatitude: userLocation.latitude,
        userLongitude: userLocation.longitude,
      ),
    );
  }

  Future<void> _onEditFieldRequested(
    EditFieldRequested event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    print('requested');
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
