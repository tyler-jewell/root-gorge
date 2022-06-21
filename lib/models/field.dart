class Field {
  Field({
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.crop,
    required this.herbicide,
  });

  final String userId;
  final double latitude;
  final double longitude;
  final String crop;
  final String herbicide;

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      userId: json['userId'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      crop: json['crop'] as String,
      herbicide: json['herbicide'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
      'crop': crop,
      'herbicide': herbicide,
    };
  }
}
