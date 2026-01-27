import 'package:gas_app/features/gas_stations/domain/entities/location.dart';

class LocationDTO {
  final double latitude;
  final double longitude;

  LocationDTO({required this.latitude, required this.longitude});

  Location toEntity() {
    return Location(latitude: latitude, longitude: longitude);
  }
}
