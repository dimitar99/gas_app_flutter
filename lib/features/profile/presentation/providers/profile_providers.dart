import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/network/providers/dio_provider.dart';
import 'package:gas_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:gas_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:gas_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:gas_app/features/profile/domain/repositories/profile_repository.dart';

final profileRemoteDatasource = Provider<ProfileRemoteDatasource>((ref) {
  final dio = ref.read(dioProvider);
  return ProfileRemoteDatasourceImpl(dio);
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remote = ref.read(profileRemoteDatasource);
  final userStorage = ref.read(userStorageProvider);

  return ProfileRepositoryImpl(remote, userStorage);
});
