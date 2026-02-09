import 'package:flutter/material.dart';

class FuelLogo extends StatelessWidget {
  const FuelLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF4f39f6),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.local_gas_station, color: Colors.white, size: 40),
    );
  }
}
