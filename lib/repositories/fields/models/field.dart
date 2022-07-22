import 'package:cloud_firestore/cloud_firestore.dart';

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
