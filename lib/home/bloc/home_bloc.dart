import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/repositories/fields/field_repository.dart';
import 'package:root_gorge/repositories/fields/models/field.dart';
import 'package:root_gorge/repositories/local/local_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required FieldsRepository fieldsRepository,
  })  : _fieldsRepository = fieldsRepository,
        super(const HomeState()) {
    on<FieldsRequested>(_onFieldsRequested);
  }

  final FieldsRepository _fieldsRepository;

  Future<void> _onFieldsRequested(
    FieldsRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final localRepository = LocalRepository();

    final fields = await _fieldsRepository.getFields();

    final markers = <Marker>[];

    print(event.devicePixelRatio);

    for (final field in fields) {
      final icon = await localRepository.getBitmap(
        cropType: field.crop,
        herbicideType: field.herbicide,
        devicePixelRatio: event.devicePixelRatio,
      );
      final fieldId = '${field.latitude}-${field.longitude}';

      markers.add(
        Marker(
          markerId: MarkerId(fieldId),
          position: LatLng(field.latitude, field.longitude),
          icon: icon,
        ),
      );
    }

    emit(
      state.copyWith(
        status: HomeStatus.success,
        fields: fields,
        markers: markers.toSet(),
      ),
    );
  }
}
