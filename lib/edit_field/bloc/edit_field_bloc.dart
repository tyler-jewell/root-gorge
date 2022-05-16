import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:root_gorge/models/crop_type.dart';
import 'package:root_gorge/models/field.dart';
import 'package:root_gorge/models/geo.dart';
import 'package:root_gorge/models/herbicide.dart';
import 'package:root_gorge/repository/fields_repository.dart';

part 'edit_field_event.dart';
part 'edit_field_state.dart';

class EditFieldBloc extends Bloc<EditFieldEvent, EditFieldState> {
  EditFieldBloc({
    required FieldsRepository fieldsRepository,
    required Field? initialField,
  })  : _fieldsRepository = fieldsRepository,
        super(
          EditFieldState(
            initialField: initialField,
            mapPoints: initialField?.mapPoints ?? const <Geo>[],
            herbicideId: initialField?.herbicideId ?? '',
            cropTypeId: initialField?.cropTypeId ?? '',
          ),
        ) {
    on<EditFieldMapPointsChanged>(_onPointsChanged);
    on<EditFieldCropTypeChanged>(_onCropTypeChanged);
    on<EditFieldHerbicideChanged>(_onHerbicideChanged);
    on<EditFieldSubmitted>(_onSubmitted);
    on<EditFieldRequested>(_onEditFieldRequested);
  }

  final FieldsRepository _fieldsRepository;

  void _onPointsChanged(
    EditFieldMapPointsChanged event,
    Emitter<EditFieldState> emit,
  ) {
    emit(state.copyWith(mapPoints: event.mapPoints));
  }

  void _onCropTypeChanged(
    EditFieldCropTypeChanged event,
    Emitter<EditFieldState> emit,
  ) {
    emit(state.copyWith(cropTypeId: event.cropTypeId));
  }

  void _onHerbicideChanged(
    EditFieldHerbicideChanged event,
    Emitter<EditFieldState> emit,
  ) {
    emit(state.copyWith(herbicideId: event.herbicideId));
  }

  Future<void> _onSubmitted(
    EditFieldSubmitted event,
    Emitter<EditFieldState> emit,
  ) async {
    emit(state.copyWith(status: EditFieldStatus.loading));

    final field = Field(
      id: state.initialField?.id ?? '',
      mapPoints: state.mapPoints,
      cropTypeId: state.cropTypeId,
      herbicideId: state.herbicideId,
    );

    try {
      await _fieldsRepository.updateField(field);
      emit(state.copyWith(status: EditFieldStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditFieldStatus.failure));
    }
  }

  Future<void> _onEditFieldRequested(
    EditFieldRequested event,
    Emitter<EditFieldState> emit,
  ) async {
    emit(state.copyWith(status: EditFieldStatus.loading));

    final cropTypes = await _fieldsRepository.getCropTypes();

    final herbicides = await _fieldsRepository.getHerbicides();

    emit(
      state.copyWith(
        status: EditFieldStatus.success,
        cropTypes: cropTypes,
        herbicides: herbicides,
      ),
    );
  }
}
