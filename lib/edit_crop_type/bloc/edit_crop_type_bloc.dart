import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';

part 'edit_crop_type_event.dart';
part 'edit_crop_type_state.dart';

class EditCropTypeBloc extends Bloc<EditCropTypeEvent, EditCropTypeState> {
  EditCropTypeBloc({
    required FieldsRepository fieldsRepository,
  })  : _fieldsRepository = fieldsRepository,
        super(const EditCropTypeState()) {
    on<EditCropTypeNameChanged>(_onNameChanged);
    on<EditCropTypeColorChanged>(_onColorChanged);
    on<EditCropPickingColorCompleted>(_onColorCompleted);
    on<EditCropTypeSubmitted>(_onSubmitted);
  }

  final FieldsRepository _fieldsRepository;

  void _onNameChanged(
    EditCropTypeNameChanged event,
    Emitter<EditCropTypeState> emit,
  ) {
    emit(state.copyWith(cropTypeName: event.name));
  }

  void _onColorChanged(
    EditCropTypeColorChanged event,
    Emitter<EditCropTypeState> emit,
  ) {
    emit(state.copyWith(cropTypeColor: event.color));
  }

  void _onColorCompleted(
      EditCropPickingColorCompleted event, Emitter<EditCropTypeState> emit) {
    emit(state.copyWith(pickingColor: true));
  }

  Future<void> _onSubmitted(
    EditCropTypeSubmitted event,
    Emitter<EditCropTypeState> emit,
  ) async {
    emit(state.copyWith(status: EditCropTypeStatus.loading));

    final cropType = CropType(
      name: state.cropTypeName,
      labelColor: state.cropTypeColor!,
    );

    try {
      await _fieldsRepository.saveCropType(cropType);
      emit(state.copyWith(status: EditCropTypeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditCropTypeStatus.failure));
    }
  }
}
