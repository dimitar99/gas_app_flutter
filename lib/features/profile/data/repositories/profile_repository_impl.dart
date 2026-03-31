import 'package:gas_app/core/storage/user_storage.dart';
import 'package:gas_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:gas_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;
  final UserStorage userStorage;

  ProfileRepositoryImpl(this.remoteDatasource, this.userStorage);

  @override
  Future<bool> updatePreferences(
    String fuel,
    double tankSize,
    double radius,
  ) async {
    try {
      final user = await remoteDatasource.updatePreferences(
        fuel,
        tankSize,
        radius,
      );

      await userStorage.saveUser(user.toEntity());

      return true;
    } catch (e) {
      return false;
    }
  }
}
