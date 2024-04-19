part of 'geolocator_provider.dart';

@freezed
sealed class GeolocatorState with _$GeolocatorState {
  const factory GeolocatorState.initial() = _GeolocatorInitialState;
  const factory GeolocatorState.checking() = GeolocatorCheckingState;
  const factory GeolocatorState.locating() = GeolocatorLocatingState;
  const factory GeolocatorState.error({
    required String message,
  }) = _GeolocatorErrorState;
  const factory GeolocatorState.deneid({
    required LocationPermissionStatus status,
  }) = GeolocatorPermissionDeneidState;
  const factory GeolocatorState.localited({
    required Location location,
  }) = GeolocatorLocalitedState;
}

extension GeolocatorStateX on GeolocatorState {
  Location? get location => switch (this) {
        GeolocatorLocalitedState(location: final location) => location,
        _ => null,
      };
}
