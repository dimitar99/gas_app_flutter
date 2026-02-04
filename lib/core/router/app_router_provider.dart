import 'package:gas_app/core/router/routes.dart';
import 'package:gas_app/features/auth/presentation/auth_page.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:gas_app/features/auth/presentation/state/auth_state.dart';
import 'package:gas_app/features/gas_stations/presentation/pages/gas_stations_page.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.auth,
    redirect: (context, state) {
      final auth = ref.watch(authNotifierProvider);

      if (auth.status == AuthStateStatus.unauthenticated) {
        return AppRoutes.auth;
      }

      if (auth.status == AuthStateStatus.authenticated) {
        return AppRoutes.gasStations;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: AppRoutes.gasStations,
        builder: (context, state) => const GasStationsPage(),
      ),
    ],
  );
});
