import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/repositories/fields/field_repository.dart';
import 'package:root_gorge/repositories/fields/models/field.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required FieldsRepository fieldsRepository,
  })  : _fieldsRepository = fieldsRepository,
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

    // final markers = Set<Marker>.of(
    //   await Future.wait(
    //     fields.map((field) => field.toMarker()).toList(),
    //   ),
    // );

    emit(
      state.copyWith(
        status: HomeStatus.success,
        fields: fields,
      ),
    );
  }
}

Marker fieldToMarker(Field field) {
  final markerId = '${field.latitude}-${field.longitude}';
  final icon = _getBitmap(
    cropType: field.crop,
    herbicideType: field.herbicide,
  );

  return Marker(
    markerId: MarkerId(markerId),
    position: LatLng(field.latitude, field.longitude),
    icon: Future.wait<BitmapDescriptor>(
      () => _getBitmap(
        cropType: field.crop,
        herbicideType: field.herbicide,
      ),
    ),
  );
}

Future<BitmapDescriptor> _getBitmap({
  required String cropType,
  required String herbicideType,
}) async {
  late String file;
  if (cropType == 'Corn') {
    if (herbicideType == 'Dicamba') {
      file = 'assets/markers/corn-dicamba.png';
    } else if (herbicideType == 'Enlist') {
      file = 'assets/markers/corn-enlist.png';
    } else if (herbicideType == 'Roundup') {
      file = 'assets/markers/corn-roundup.png';
    } else if (herbicideType == 'Non-GMO') {
      file = 'assets/markers/corn-non-gmo.png';
    } else if (herbicideType == 'Organic') {
      file = 'assets/markers/corn-organic.png';
    }
  } else if (cropType == 'Soybean') {
    if (herbicideType == 'Dicamba') {
      file = 'assets/markers/soybean-dicamba.png';
    } else if (herbicideType == 'Enlist') {
      file = 'assets/markers/soybean-enlist.png';
    } else if (herbicideType == 'Roundup') {
      file = 'assets/markers/soybean-roundup.png';
    } else if (herbicideType == 'Non-GMO') {
      file = 'assets/markers/soybean-non-gmo.png';
    } else if (herbicideType == 'Organic') {
      file = 'assets/markers/soybean-organic.png';
    }
  } else if (cropType == 'Wheat') {
    if (herbicideType == 'Dicamba') {
      file = 'assets/markers/wheat-dicamba.png';
    } else if (herbicideType == 'Enlist') {
      file = 'assets/markers/wheat-enlist.png';
    } else if (herbicideType == 'Roundup') {
      file = 'assets/markers/wheat-roundup.png';
    } else if (herbicideType == 'Non-GMO') {
      file = 'assets/markers/wheat-non-gmo.png';
    } else if (herbicideType == 'Organic') {
      file = 'assets/markers/wheat-organic.png';
    }
  }

  return await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: Size(58, 58)),
    file,
  );
}
