import 'package:dio/dio.dart';
import 'package:gas_app/features/auth/data/dto/auth_response_dto.dart';

class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource(this.dio);

  Future<AuthResponseDto> login(String email, String password) async {
    final response = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return AuthResponseDto.fromJson(response.data);
  }

  Future<AuthResponseDto> register({
    required String email,
    required String password,
    required String fuel,
    required double tankSize,
  }) async {
    final response = await dio.post(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        'fuel': fuel,
        'tankSize': tankSize,
      },
    );

    return AuthResponseDto.fromJson(response.data);
  }

  Future<void> logout() async => await dio.post('/auth/logout');
}
