import 'package:dio/dio.dart';
import 'package:gas_app/features/auth/data/dto/user_model_dto.dart';

abstract class ProfileRemoteDatasource {
  Future<UserModelDto> updatePreferences(
    String fuel,
    double tankSize,
    double radius,
  );
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final Dio dio;
  ProfileRemoteDatasourceImpl(this.dio);

  @override
  Future<UserModelDto> updatePreferences(
    String fuel,
    double tankSize,
    double radius,
  ) async {
    final resp = await dio.put(
      "/profile",
      data: {"fuel": fuel, "tankSize": tankSize, "searchRadius": radius},
    );

    return UserModelDto.fromJson(resp.data['user']);
  }
}
