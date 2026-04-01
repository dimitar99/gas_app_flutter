import 'package:gas_app/features/gas_stations/data/dto/location_dto.dart';
import 'package:gas_app/features/gas_stations/data/dto/prices_dto.dart';
import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';

class GasStationModelDTO {
  final String id;
  final String name;
  final String schedule;
  final PricesDTO prices;
  final LocationDTO location;
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
      prices: PricesDTO(
        gasoline95:
            double.tryParse(json['prices']['gasoline95'].toString()) ?? 0,
        gasoline98:
            double.tryParse(json['prices']['gasoline98'].toString()) ?? 0,
        dieselA: double.tryParse(json['prices']['dieselA'].toString()) ?? 0,
        dieselB: double.tryParse(json['prices']['dieselB'].toString()) ?? 0,
        adblue: double.tryParse(json['prices']['adblue'].toString()) ?? 0,
        glp: double.tryParse(json['prices']['glp'].toString()) ?? 0,
        gnc: double.tryParse(json['prices']['gnc'].toString()) ?? 0,
      ),
      location: LocationDTO(
        latitude: json['location']['coordinates'][0] ?? 0,
        longitude: json['location']['coordinates'][1] ?? 0,
      ),
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
      prices: prices.toEntity(),
      location: location.toEntity(),
      province: province,
      city: city,
      address: address,
    );
  }
}
