import 'package:gas_app/features/gas_stations/domain/entities/location.dart';
import 'package:gas_app/features/gas_stations/domain/entities/prices.dart';

class GasStation {
  final String name;
  final String? schedule;
  final Prices prices;
  final Location location;
  final String? province;
  final String? city;
  final String? address;

  GasStation({
    required this.name,
    this.schedule,
    required this.prices,
    required this.location,
    this.province,
    this.city,
    this.address,
  });
}
