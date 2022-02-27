import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:meta/meta.dart';
import 'package:root_gorge/map/models/plot.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapLoadInProgress()) {
    on<MapEvent>(
      (event, emit) async {
        // if (event is MarkerAddedToPlot) {
        //   await Future.delayed(const Duration(milliseconds: 1000), () {});

        //   final newPlot = Plot(id: event.id, plotMarkers: )

        //   emit(MapLoadSuccess());
        // }
      },
    );
  }
}
