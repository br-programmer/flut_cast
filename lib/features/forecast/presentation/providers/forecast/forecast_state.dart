part of 'forecast_provider.dart';

@freezed
class ForecastState with _$ForecastState {
  const factory ForecastState.loading() = ForecastLoadingState;
  const factory ForecastState.loaded({
    required City city,
    required Forecast forecast,
  }) = ForecastLoadedState;
  const factory ForecastState.error({
    required HttpRequestFailure failure,
  }) = ForecastLoadErrorState;
}

extension ForecastStateX on ForecastState {
  Forecast? get forecast => switch (this) {
        final ForecastLoadedState state => state.forecast,
        _ => null,
      };
}
