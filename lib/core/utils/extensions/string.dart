extension StringExtension on String {
  String get orPriceNotAvailable => isNotEmpty ? '$this€' : 'No disponible';
  String get capitalizeFirst =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
