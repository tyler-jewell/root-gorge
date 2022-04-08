import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

part 'fields_overview_event.dart';
part 'fields_overview_state.dart';

class FieldsOverviewBloc
    extends Bloc<FieldsOverviewEvent, FieldsOverviewState> {
  FieldsOverviewBloc({
    required FieldsRepository fieldsRepository,
  })  : _fieldsRepository = fieldsRepository,
        super(const FieldsOverviewState()) {
    on<FieldsOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<UserLocationRequested>(_onUserLocationRequested);
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

  Future<void> _onUserLocationRequested(
    UserLocationRequested event,
    Emitter<FieldsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => FieldsOverviewStatus.loading));

    final currentLocation = await Location().getLocation();

    final _userLatLng =
        LatLng(currentLocation.latitude!, currentLocation.longitude!);

    emit(
      state.copyWith(
        status: () => FieldsOverviewStatus.success,
        currentLocation: _userLatLng,
      ),
    );
  }
}
