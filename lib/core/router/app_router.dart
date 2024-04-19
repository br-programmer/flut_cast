import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/features/features.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (_) => GoRouter(
    initialLocation: Routes.cities.path,
    routes: AppRouter.routes,
  ),
);

class AppRouter {
  const AppRouter._();

  static List<GoRoute> get routes => [
        GoRoute(
          path: Routes.forecast.path,
          name: Routes.forecast.name,
          pageBuilder: ForecastScreen.pageBuilder,
        ),
        GoRoute(
          path: Routes.cities.path,
          name: Routes.cities.name,
          pageBuilder: CitiesScreen.pageBuilder,
        ),
      ];
}
