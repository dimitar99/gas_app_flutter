class Location {
  final double? latitude;
  final double? longitude;

  Location({this.latitude, this.longitude});

  bool get hasCoordinates => latitude != null && longitude != null;
}
