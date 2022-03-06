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
    on<EditFieldMapPointsChanged>(_onMapPointsChanged);
    on<EditFieldBeanTypeChanged>(_onBeanTypeChanged);
    on<EditFieldSubmitted>(_onSubmitted);
  }

  final FieldsRepository _fieldsRepository;

  void _onMapPointsChanged(
    EditFieldMapPointsChanged event,
    Emitter<EditFieldState> emit,
  ) {
    emit(state.copyWith(mapPoints: event.mapPoints));
  }

  void _onBeanTypeChanged(
    EditFieldBeanTypeChanged event,
    Emitter<EditFieldState> emit,
  ) {
    emit(state.copyWith(beanType: event.beanType));
  }

  Future<void> _onSubmitted(
    EditFieldSubmitted event,
    Emitter<EditFieldState> emit,
  ) async {
    emit(state.copyWith(status: EditFieldStatus.loading));

    final field = Field(mapPoints: state.mapPoints, beanType: state.beanType);

    try {
      await _fieldsRepository.saveField(field);
      emit(state.copyWith(status: EditFieldStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditFieldStatus.failure));
    }
  }
}
