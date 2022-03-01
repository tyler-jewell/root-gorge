import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/map_repository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({required MapRepository mapRepository})
      : _mapRepository = mapRepository,
        super(MapLoading()) {
    on<MapSubscriptionRequested>(_onSubscriptionRequested);
    on<AddPolygon>(_onAddPolygon);
    on<AddPolygonPoint>(_onAddPolygonPoint);
  }

  final MapRepository _mapRepository;

  Future<void> _onSubscriptionRequested(
    MapSubscriptionRequested event,
    Emitter<MapState> emit,
  ) async {
    emit(MapLoading());

    await Future.delayed(const Duration(seconds: 1), () {});

    await emit.forEach<Set<Polygon>>(
      _mapRepository.getPolygons(),
      onData: (polygons) => MapLoaded(polygons: polygons),
    );
  }

  Future<void> _onAddPolygonPoint(
    AddPolygonPoint event,
    Emitter<MapState> emit,
  ) async {}

  Future<void> _onAddPolygon(
    AddPolygon event,
    Emitter<MapState> emit,
  ) async {
    emit(AddingMap());
    const _newPoly = Polygon(
      polygonId: PolygonId('polygon_2'),
      points: [
        LatLng(40.513179818875024, -104.95358998656732),
        LatLng(40.51316359655523, -104.95403594974508),
        LatLng(40.51317657441137, -104.95359212036244),
        LatLng(40.513011106557485, -104.95391645721898),
      ],
      fillColor: Colors.blue,
      strokeColor: Colors.blue,
      strokeWidth: 2,
    );

    await _mapRepository.addPolygon(_newPoly);
  }
}
