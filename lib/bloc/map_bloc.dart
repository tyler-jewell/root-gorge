import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/map_repository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({required MapRepository mapRepository})
      : _mapRepository = mapRepository,
        super(MapInitial()) {
    on<MapSubscriptionRequested>(_onSubscriptionRequested);
    on<AddPolygon>(_onAddPolygon);
  }

  final MapRepository _mapRepository;

  Future<void> _onSubscriptionRequested(
    MapSubscriptionRequested event,
    Emitter<MapState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1), () {});

    await emit.forEach<Set<Polygon>>(
      _mapRepository.getPolygons(),
      onData: (polygons) => MapLoaded(polygons: polygons),
    );
  }

  Future<void> _onAddPolygon(
    AddPolygon event,
    Emitter<MapState> emit,
  ) async {
    await _mapRepository.addPolygon(event.polygon);
  }
}
