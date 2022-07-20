import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Field {
  Field({
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.crop,
    required this.herbicide,
    this.phoneNumber,
    this.name,
  });
  factory Field.fromDocument(DocumentSnapshot document) {
    return Field.fromJson(document.data()! as Map<String, Object?>);
  }

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      userId: json['userId'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      crop: json['crop'] as String,
      herbicide: json['herbicide'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      name: json['name'] as String?,
    );
  }

  final String userId;
  final double latitude;
  final double longitude;
  final String crop;
  final String herbicide;
  final String? phoneNumber;
  final String? name;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
      'crop': crop,
      'herbicide': herbicide,
      'phoneNumber': phoneNumber,
      'name': name,
    };
  }

  Future<Marker> toMarker() async {
    return Marker(
      markerId: MarkerId(userId),
      position: LatLng(latitude, longitude),
      icon: await _getBitmap(
        cropType: crop,
        herbicideType: herbicide,
      ),
      infoWindow: InfoWindow(
        title: crop,
        snippet: herbicide,
      ),
    );
  }

  Field copyWith({
    String? userId,
    double? latitude,
    double? longitude,
    String? crop,
    String? herbicide,
    String? phoneNumber,
    String? name,
  }) {
    return Field(
      userId: userId ?? this.userId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      crop: crop ?? this.crop,
      herbicide: herbicide ?? this.herbicide,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
    );
  }
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

  return BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: Size(58, 58)),
    file,
  );
}
