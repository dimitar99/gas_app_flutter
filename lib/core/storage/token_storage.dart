import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenStorage {
  Future<void> saveAccessToken(String token, DateTime expirationDate);
  Future<void> saveRefreshToken(String token, DateTime expirationDate);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<bool> isValidAccessToken();
  Future<bool> isValidRefreshToken();
  Future<void> clear();
}

class SecureTokenStorage implements TokenStorage {
  final FlutterSecureStorage _storage;

  SecureTokenStorage(this._storage);

  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';
  static const _accessKeyExpirationDate = 'access_token_expiration_date';
  static const _refreshKeyExpirationDate = 'refresh_token_expiration_date';

  @override
  Future<void> saveAccessToken(String token, DateTime expirationDate) async {
    await _storage.write(key: _accessKey, value: token);
    await _storage.write(
      key: _accessKeyExpirationDate,
      value: expirationDate.toIso8601String(),
    );
  }

  @override
  Future<void> saveRefreshToken(String token, DateTime expirationDate) async {
    await _storage.write(key: _refreshKey, value: token);
    await _storage.write(
      key: _refreshKeyExpirationDate,
      value: expirationDate.toIso8601String(),
    );
  }

  @override
  Future<String?> getAccessToken() => _storage.read(key: _accessKey);

  @override
  Future<String?> getRefreshToken() => _storage.read(key: _refreshKey);

  @override
  Future<bool> isValidAccessToken() async {
    final token = await getAccessToken();
    final expirationDate = await _storage.read(key: _accessKeyExpirationDate);
    return token != null &&
        expirationDate != null &&
        DateTime.parse(
          expirationDate,
        ).isAfter(DateTime.now().add(const Duration(minutes: 1)));
  }

  @override
  Future<bool> isValidRefreshToken() async {
    final token = await getRefreshToken();
    final expirationDate = await _storage.read(key: _refreshKeyExpirationDate);
    return token != null &&
        expirationDate != null &&
        DateTime.parse(
          expirationDate,
        ).isAfter(DateTime.now().add(const Duration(minutes: 1)));
  }

  @override
  Future<void> clear() => _storage.deleteAll();
}
