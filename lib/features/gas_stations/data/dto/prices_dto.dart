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
