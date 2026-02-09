import 'package:dio/dio.dart';
import 'package:gas_app/core/network/error_mapper.dart';
import 'package:gas_app/core/network/exceptions/app_exception.dart';
import 'package:gas_app/features/auth/data/dto/auth_response_dto.dart';

class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource(this.dio);

  Future<AuthResponseDto> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      return AuthResponseDto.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        throw DioErrorMapper.map(e);
      }
      throw const AppException('Ha ocurrido un error');
    }
  }

  Future<AuthResponseDto> register(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: {'email': email, 'password': password},
      );
      return AuthResponseDto.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        throw DioErrorMapper.map(e);
      }
      throw const AppException('Ha ocurrido un error');
    }
  }

  Future<void> logout() async {
    try {
      await dio.post('/auth/logout');
    } catch (e) {
      if (e is DioException) {
        throw DioErrorMapper.map(e);
      }
      throw const AppException('Ha ocurrido un error');
    }
  }
}
