import 'package:gas_app/features/auth/data/dto/user_model_dto.dart';

class AuthResponseDto {
  final String accessToken;
  final String refreshToken;
  final UserModelDto user;

  AuthResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: UserModelDto.fromJson(json['user']),
    );
  }
}
