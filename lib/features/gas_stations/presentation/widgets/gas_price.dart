import 'package:flutter/material.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';

enum GasType {
  gasoline95("Gasolina 95"),
  gasoline98("Gasolina 98"),
  dieselA("Diesel A"),
  dieselB("Diesel B"),
  adblue("Adblue"),
  glp("GLP"),
  gnc("GNC");

  final String name;
  const GasType(this.name);
}

class GasDetailPrice extends StatelessWidget {
  final GasType type;
  final double price;
  final bool userPrice;

  const GasDetailPrice(
    this.type,
    this.price, {
    super.key,
    this.userPrice = false,
  });

  Color colorByType() {
    switch (type) {
      case GasType.gasoline95:
        return Colors.lightGreen;
      case GasType.gasoline98:
        return Colors.green;
      case GasType.dieselA:
        return Colors.grey;
      case GasType.dieselB:
        return Colors.black;
      case GasType.adblue:
        return Colors.blue;
      case GasType.glp:
        return Colors.lime;
      case GasType.gnc:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: colorByType().withValues(alpha: 0.3),
        border: Border.all(
          color: userPrice ? AppColors.primary : Colors.transparent,
          width: userPrice ? 3 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '${type.name}: $price€',
        style: AppTextStyles.heading4.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
