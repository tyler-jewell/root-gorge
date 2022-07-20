import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/repositories/fields/field_repository.dart';
import 'package:root_gorge/repositories/fields/models/field.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required FieldsRepository fieldsRepository})
      : _fieldsRepository = fieldsRepository,
        super(const HomeState()) {
    on<FieldsRequested>(_onFieldsRequested);
  }

  final FieldsRepository _fieldsRepository;

  Future<void> _onFieldsRequested(
    FieldsRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final fields = await _fieldsRepository.getFields();

    final markers = await Future.wait(
      fields.map((field) => field.toMarker()).toList(),
    );

    emit(
      state.copyWith(
        status: HomeStatus.success,
        fields: fields,
        markers: markers,
      ),
    );
  }
}
