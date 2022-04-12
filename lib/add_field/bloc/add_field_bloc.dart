import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';

part 'add_field_event.dart';
part 'add_field_state.dart';

class AddFieldBloc extends Bloc<AddFieldEvent, AddFieldState> {
  AddFieldBloc({
    required FieldsRepository fieldsRepository,
  })  : _fieldsRepository = fieldsRepository,
        super(const AddFieldState()) {
    on<AddFieldMapPointsChanged>(_onMapPointsChanged);
    on<AddFieldBeanTypeChanged>(_onBeanTypeChanged);
    on<AddFieldSubmitted>(_onSubmitted);
  }

  final FieldsRepository _fieldsRepository;

  void _onMapPointsChanged(
    AddFieldMapPointsChanged event,
    Emitter<AddFieldState> emit,
  ) {
    emit(state.copyWith(mapPoints: event.mapPoints));
  }

  void _onBeanTypeChanged(
    AddFieldBeanTypeChanged event,
    Emitter<AddFieldState> emit,
  ) {
    emit(state.copyWith(beanType: event.beanType));
  }

  Future<void> _onSubmitted(
    AddFieldSubmitted event,
    Emitter<AddFieldState> emit,
  ) async {
    emit(state.copyWith(status: AddFieldStatus.loading));

    final field = Field(mapPoints: state.mapPoints, beanType: state.beanType);

    try {
      await _fieldsRepository.saveField(field);
      emit(state.copyWith(status: AddFieldStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddFieldStatus.failure));
    }
  }
}
