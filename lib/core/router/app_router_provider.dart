import 'package:gas_app/core/router/routes.dart';
import 'package:gas_app/features/gas_stations/presentation/pages/gas_stations_page.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.auth,
    redirect: (context, state) {
      return AppRoutes.gasStations;
      // final isLoggedIn = authState.isAuthenticated;
      // final isOnLogin = state.matchedLocation == AppRoutes.auth;

      // if (!isLoggedIn && !isOnLogin) {
      //   return AppRoutes.auth;
      // }

      // if (isLoggedIn && isOnLogin) {
      //   return AppRoutes.gasStations;
      // }

      return null;
    },
    routes: [
      // GoRoute(
      //   path: AppRoutes.auth,
      //   builder: (context, state) => const AuthPage(),
      // ),
      GoRoute(
        path: AppRoutes.gasStations,
        builder: (context, state) => const GasStationsPage(),
      ),
    ],
  );
});
