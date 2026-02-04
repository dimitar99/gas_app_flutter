import 'package:gas_app/features/auth/domain/entities/user.dart';

class UserModelDto {
  final String id;
  final String email;
  final String fuel;
  final int tankSize;
  final int searchRadius;
  final DateTime createdAt;

  UserModelDto({
    required this.id,
    required this.email,
    required this.fuel,
    required this.tankSize,
    required this.searchRadius,
    required this.createdAt,
  });

  factory UserModelDto.fromJson(Map<String, dynamic> json) {
    return UserModelDto(
      id: json['_id'],
      email: json['email'],
      fuel: json['fuel'],
      tankSize: json['tankSize'],
      searchRadius: json['searchRadius'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      fuel: fuel,
      tankSize: tankSize,
      searchRadius: searchRadius,
      createdAt: createdAt,
    );
  }
}
