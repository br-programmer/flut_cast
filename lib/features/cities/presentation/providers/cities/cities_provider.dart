import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';
import 'package:fc_local_storage/fc_local_storage.dart';
import 'package:flut_cast/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

part 'cities_provider.freezed.dart';
part 'cities_state.dart';

final citiesNotifier = StateNotifierProvider<CitiesProvider, CitiesState>(
  (ref) => CitiesProvider(
    const CitiesState.loading(),
    searchRepository: ref.read(Repositories.search),
    location: ref.watch(geolocator).location,
    citiesLocalService: ref.read(Services.cities),
  )..loadLocalCities(),
);

class CitiesProvider extends StateNotifier<CitiesState> {
  CitiesProvider(
    super.state, {
    required ISearchRepository searchRepository,
    required Location? location,
    required CitiesLocalService citiesLocalService,
  })  : _searchRepository = searchRepository,
        _location = location,
        _citiesLocalService = citiesLocalService;

  final ISearchRepository _searchRepository;
  final CitiesLocalService _citiesLocalService;
  final Location? _location;

  Future<void> loadLocalCities() async {
    if (_location == null) return;
    await _citiesLocalService.start();
    final cities = await _citiesLocalService.cities();
    if (cities.isNotEmpty) {
      state = CitiesState.loadedState(cities: cities.firstMyLocation);
    }
    loadMyLocation();
  }

  Future<void> loadMyLocation() async {
    if (_location == null) return;
    final request = ReverseRequest(lat: _location.lat, lon: _location.lon);
    final result = await _searchRepository.reverse(request: request);
    final city = _newCityFromResult(result);
    state = _newLoadedStateFromCity(city);
  }

  CitiesState _newLoadedStateFromCity(City? city) {
    final cities = [...state.cities];
    if (city == null) {
      return CitiesState.loadedState(cities: cities.firstMyLocation);
    }
    final index = cities.indexWhere((city) => city.myLocation);
    if (index != -1) {
      cities[index] = city;
    } else {
      cities.add(city);
    }
    return CitiesState.loadedState(cities: cities.firstMyLocation);
  }

  City? _newCityFromResult(Either<HttpRequestFailure, City> result) {
    return switch (result) {
      Right(value: final cityResult) => cityResult.copyWith(
          myLocation: true,
          id: _cityId,
        ),
      Left() => _myCity,
    };
  }

  Future<void> addNewCity(City city) async {
    final newCity = city.copyWith(id: _citiesLocalService.uuid);
    state = CitiesState.loadedState(
      cities: [...state.cities.firstMyLocation, newCity],
    );
    return _citiesLocalService.setCity(newCity);
  }

  Future<bool> deleteCity(City city) async {
    final cities = _cities.firstMyLocation..remove(city);
    state = CitiesState.loadedState(cities: cities);
    await _citiesLocalService.deleteCity(city.id!);
    return true;
  }

  City? get _myCity => state.cities.firstWhereOrNull((city) => city.myLocation);
  List<City> get _cities => [...state.cities];
  String get _cityId {
    return _myCity != null ? _myCity!.id! : _citiesLocalService.uuid;
  }
}

extension on List<City> {
  List<City> get firstMyLocation {
    return this..sort((a, b) => a.myLocation ? 0 : 1);
  }
}
