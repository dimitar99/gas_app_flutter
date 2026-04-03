import 'package:gas_app/features/gas_stations/domain/entities/prices.dart';

class PricesDTO {
  final double gasoline95;
  final double gasoline98;
  final double dieselA;
  final double dieselB;
  final double adblue;
  final double glp;
  final double gnc;

  PricesDTO({
    required this.gasoline95,
    required this.gasoline98,
    required this.dieselA,
    required this.dieselB,
    required this.adblue,
    required this.glp,
    required this.gnc,
  });

  factory PricesDTO.fromJson(Map<String, dynamic> json) {
    return PricesDTO(
      gasoline95: double.tryParse(json['gasoline95'].toString()) ?? 0,
      gasoline98: double.tryParse(json['gasoline98'].toString()) ?? 0,
      dieselA: double.tryParse(json['dieselA'].toString()) ?? 0,
      dieselB: double.tryParse(json['dieselB'].toString()) ?? 0,
      adblue: double.tryParse(json['adblue'].toString()) ?? 0,
      glp: double.tryParse(json['glp'].toString()) ?? 0,
      gnc: double.tryParse(json['gnc'].toString()) ?? 0,
    );
  }

  Prices toEntity() {
    return Prices(
      gasoline95: gasoline95,
      gasoline98: gasoline98,
      dieselA: dieselA,
      dieselB: dieselB,
      adblue: adblue,
      glp: glp,
      gnc: gnc,
    );
  }
}
