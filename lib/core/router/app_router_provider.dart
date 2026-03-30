import 'package:gas_app/core/router/router_listenable.dart';
import 'package:gas_app/core/router/routes.dart';
import 'package:gas_app/features/auth/presentation/auth_page.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:gas_app/features/auth/presentation/state/auth_state.dart';
import 'package:gas_app/features/gas_stations/presentation/gas_stations_page.dart';
import 'package:gas_app/features/profile/presentation/profile_page.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final listenable = ref.watch(routerListenableProvider);

  return GoRouter(
    initialLocation: AppRoutes.auth,
    refreshListenable: listenable,
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      final status = authState.status;

      final isLoggingIn = state.matchedLocation == AppRoutes.auth;

      if (status == AuthStateStatus.unauthenticated) {
        return isLoggingIn ? null : AppRoutes.auth;
      }

      if (status == AuthStateStatus.authenticated) {
        return isLoggingIn ? AppRoutes.gasStations : null;
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
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
});
