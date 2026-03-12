import 'package:gas_app/features/auth/data/dto/user_model_dto.dart';

class AuthResponseDto {
  final String accessToken;
  final String refreshToken;
  final UserModelDto user;
  final DateTime accessTokenExpirationDate;
  final DateTime refreshTokenExpirationDate;

  AuthResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.accessTokenExpirationDate,
    required this.refreshTokenExpirationDate,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      accessTokenExpirationDate: DateTime.now().add(
        Duration(seconds: json['expires_in']),
      ),
      refreshTokenExpirationDate: DateTime.now().add(
        Duration(seconds: json['refresh_expires_in']),
      ),
      user: UserModelDto.fromJson(json['user']),
    );
  }
}
