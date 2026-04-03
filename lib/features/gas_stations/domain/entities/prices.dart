import 'package:gas_app/features/gas_stations/presentation/widgets/gas_price.dart';

class Prices {
  final double? gasoline95;
  final double? gasoline98;
  final double? dieselA;
  final double? dieselB;
  final double? adblue;
  final double? glp;
  final double? gnc;

  Prices({
    this.gasoline95,
    this.gasoline98,
    this.dieselA,
    this.dieselB,
    this.adblue,
    this.glp,
    this.gnc,
  });

  double? getPrice(GasType type) {
    switch (type) {
      case GasType.gasoline95:
        return gasoline95;
      case GasType.gasoline98:
        return gasoline98;
      case GasType.dieselA:
        return dieselA;
      case GasType.dieselB:
        return dieselB;
      case GasType.adblue:
        return adblue;
      case GasType.glp:
        return glp;
      case GasType.gnc:
        return gnc;
    }
  }
}
