import 'package:gas_app/features/gas_stations/domain/entities/location.dart';

class LocationDTO {
  final double latitude;
  final double longitude;

  LocationDTO({required this.latitude, required this.longitude});

  factory LocationDTO.fromJson(Map<String, dynamic> json) {
    return LocationDTO(
      latitude: json['coordinates'][0] ?? 0,
      longitude: json['coordinates'][1] ?? 0,
    );
  }

  Location toEntity() {
    return Location(latitude: latitude, longitude: longitude);
  }
}
