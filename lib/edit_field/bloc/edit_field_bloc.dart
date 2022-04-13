import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';

part 'edit_field_event.dart';
part 'edit_field_state.dart';

class EditFieldBloc extends Bloc<EditFieldEvent, EditFieldState> {
  EditFieldBloc({
    required FieldsRepository fieldsRepository,
  })  : _fieldsRepository = fieldsRepository,
        super(const EditFieldState()) {
    on<EditFieldMapPointsChanged>(_onPointsChanged);
    on<EditFieldCropTypeChanged>(_onCropTypeChanged);
    on<EditFieldSubmitted>(_onSubmitted);
    on<EditFieldHerbicideChanged>(_onHerbicideChanged);
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
    emit(state.copyWith(cropType: event.cropType));
  }

  void _onHerbicideChanged(
    EditFieldHerbicideChanged event,
    Emitter<EditFieldState> emit,
  ) {
    emit(state.copyWith(herbicide: event.herbicide));
  }

  Future<void> _onSubmitted(
    EditFieldSubmitted event,
    Emitter<EditFieldState> emit,
  ) async {
    emit(state.copyWith(status: EditFieldStatus.loading));

    final field = Field(
      mapPoints: state.mapPoints,
      cropType: state.cropType,
      herbicide: state.herbicide,
    );

    try {
      await _fieldsRepository.saveField(field);
      emit(state.copyWith(status: EditFieldStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditFieldStatus.failure));
    }
  }
}
