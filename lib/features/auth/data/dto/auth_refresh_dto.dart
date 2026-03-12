class AuthRefreshDto {
  final String accessToken;
  final String refreshToken;
  final DateTime accessTokenExpirationDate;
  final DateTime refreshTokenExpirationDate;

  AuthRefreshDto({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpirationDate,
    required this.refreshTokenExpirationDate,
  });

  factory AuthRefreshDto.fromJson(Map<String, dynamic> json) {
    return AuthRefreshDto(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      accessTokenExpirationDate: DateTime.now().add(
        Duration(seconds: json['expires_in']),
      ),
      refreshTokenExpirationDate: DateTime.now().add(
        Duration(seconds: json['refresh_expires_in']),
      ),
    );
  }
}
