class User {
  final String id;
  final String email;
  final String fuel;
  final int tankSize;
  final int searchRadius;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.fuel,
    required this.tankSize,
    required this.searchRadius,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    email: json['email'],
    fuel: json['fuel'],
    tankSize: json['tankSize'],
    searchRadius: json['searchRadius'],
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'fuel': fuel,
    'tankSize': tankSize,
    'searchRadius': searchRadius,
    'createdAt': createdAt.toIso8601String(),
  };
}
