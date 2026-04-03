import 'package:gas_app/features/gas_stations/data/dto/location_dto.dart';
import 'package:gas_app/features/gas_stations/data/dto/prices_dto.dart';
import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';

class GasStationModelDTO {
  final String id;
  final String name;
  final String schedule;
  final PricesDTO? prices;
  final LocationDTO? location;
  final String province;
  final String city;
  final String address;

  GasStationModelDTO({
    required this.id,
    required this.name,
    required this.schedule,
    required this.prices,
    required this.location,
    required this.province,
    required this.city,
    required this.address,
  });

  factory GasStationModelDTO.fromJson(Map<String, dynamic> json) {
    return GasStationModelDTO(
      id: json['_id'] ?? "",
      name: json['name'] ?? "",
      schedule: json['schedule'] ?? "",
      prices: json['prices'] != null
          ? PricesDTO.fromJson(json['prices'])
          : null,
      location: json['location'] != null
          ? LocationDTO.fromJson(json['location'])
          : null,
      province: json['province'] ?? "",
      city: json['city'] ?? "",
      address: json['address'] ?? "",
    );
  }

  GasStation toEntity() {
    return GasStation(
      id: id,
      name: name,
      schedule: schedule,
      prices: prices?.toEntity(),
      location: location?.toEntity(),
      province: province,
      city: city,
      address: address,
    );
  }
}
