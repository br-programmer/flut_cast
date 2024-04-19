import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';
import 'package:flut_cast/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'forecast_provider.freezed.dart';
part 'forecast_state.dart';

final forecastNotifier =
    StateNotifierProviderFamily<ForecastProvider, ForecastState, City>(
  (ref, city) => ForecastProvider(
    const ForecastState.loading(),
    forecastRepository: ref.read(Repositories.forecast),
    city: city,
  )..loadForecast(),
);

class ForecastProvider extends StateNotifier<ForecastState> {
  ForecastProvider(
    super.state, {
    required IForecastRepository forecastRepository,
    required City city,
  })  : _forecastRepository = forecastRepository,
        _city = city;

  final IForecastRepository _forecastRepository;
  final City _city;

  Future<void> loadForecast() async {
    final request = ForecastRequest(lat: _city.lat, lon: _city.lon);
    final result = await _forecastRepository.forescast(request: request);
    state = switch (result) {
      Right(value: final forecast) => ForecastState.loaded(
          forecast: forecast,
          city: _city,
        ),
      Left(value: final failure) => ForecastState.error(failure: failure),
    };
  }
}
