import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalRepository {
  Future<BitmapDescriptor> getBitmap({
    required String cropType,
    required String herbicideType,
    required double devicePixelRatio,
  }) async {
    return BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        devicePixelRatio: devicePixelRatio,
        // TODO: make this dynamic
        size: const Size(50, 50),
      ),
      getBitmapKey(
        cropType: cropType,
        herbicideType: herbicideType,
      ),
    );
  }

  String getBitmapKey({
    required String cropType,
    required String herbicideType,
  }) {
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
    } else {
      return 'Add error handling here';
    }

    return file;
  }
}
