import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'add_field_event.dart';
part 'add_field_state.dart';

class AddFieldBloc extends Bloc<AddFieldEvent, AddFieldState> {
  AddFieldBloc() : super(const AddFieldState()) {
    on<AddFieldRequested>(_onAddFieldRequested);
    on<AddPolygonPoint>(_onAddPolygonPoint);
    on<UserLocationRequested>(_onUserLocationRequested);

    GoogleMapController _mapController;
  }

  void _onAddFieldRequested(
    AddFieldRequested event,
    Emitter<AddFieldState> emit,
  ) {
    emit(
      state.copyWith(
        status: AddFieldStatus.success,
        mapLatitude: event.lat,
        mapLongitude: event.lng,
      ),
    );
  }

  void _onAddPolygonPoint(
    AddPolygonPoint event,
    Emitter<AddFieldState> emit,
  ) {
    print(event.point);
  }

  void _onUserLocationRequested(
    UserLocationRequested event,
    Emitter<AddFieldState> emit,
  ) {}
}
