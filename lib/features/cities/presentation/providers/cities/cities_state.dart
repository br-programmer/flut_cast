part of 'cities_provider.dart';

@freezed
class CitiesState with _$CitiesState {
  const factory CitiesState.loading() = _CitiesLoadingState;
  const factory CitiesState.loadedState({
    required List<City> cities,
  }) = CitiesLoadedState;
  const factory CitiesState.loadedErrorState({
    required HttpRequestFailure failure,
  }) = _CitiesLoadErrorState;
}

extension CitiesStateX on CitiesState {
  List<City> get cities => switch (this) {
        CitiesLoadedState(cities: final cities) => [...cities],
        _ => [],
      };
}
