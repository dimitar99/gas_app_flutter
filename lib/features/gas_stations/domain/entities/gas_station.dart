import 'package:gas_app/features/gas_stations/domain/entities/location.dart';
import 'package:gas_app/features/gas_stations/domain/entities/prices.dart';
import 'package:geolocator/geolocator.dart';

class GasStation {
  final String id;
  final String name;
  final String? schedule;
  final Prices? prices;
  final Location? location;
  final String? province;
  final String? city;
  final String? address;
  final double? distance;

  GasStation({
    required this.id,
    required this.name,
    this.schedule,
    required this.prices,
    required this.location,
    this.province,
    this.city,
    this.address,
    this.distance,
  });

  double calculateDistance(double lat, double lng) {
    final distance =
        Geolocator.distanceBetween(
          lat,
          lng,
          location?.latitude ?? 0.0,
          location?.longitude ?? 0.0,
        ) /
        1000;
    return double.parse(distance.toStringAsFixed(2));
  }

  GasStation copyWith({double? distance}) {
    return GasStation(
      id: id,
      name: name,
      schedule: schedule,
      prices: prices,
      location: location,
      province: province,
      city: city,
      address: address,
      distance: distance ?? this.distance,
    );
  }
}
