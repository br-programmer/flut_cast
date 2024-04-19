import 'package:fc_data/fc_data.dart';
import 'package:fc_domain/fc_domain.dart';
import 'package:flut_cast/core/core.dart';
import 'package:riverpod/riverpod.dart';

class Repositories {
  const Repositories._();

  static final search = Provider<ISearchRepository>(
    (ref) => SearchRepository(http: ref.read(Providers.fcApi)),
  );

  static final forecast = Provider<IForecastRepository>(
    (ref) => ForecastRepository(http: ref.read(Providers.fcApi)),
  );
}
