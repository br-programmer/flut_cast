import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';
import 'package:fc_geolocator/fc_geolocator.dart';
import 'package:flut_cast/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

part 'geolocator_provider.freezed.dart';
part 'geolocator_state.dart';

final geolocator = StateNotifierProvider<GeolocatorProvider, GeolocatorState>(
  (ref) => GeolocatorProvider(
    const GeolocatorState.initial(),
    geolocatorService: ref.read(Services.geolocator),
  )..requestPermission(),
);

class GeolocatorProvider extends StateNotifier<GeolocatorState> {
  GeolocatorProvider(
    super.state, {
    required GeolocatorService geolocatorService,
  }) : _geolocatorService = geolocatorService;
  final GeolocatorService _geolocatorService;

  Future<void> requestPermission() async {
    final result = await _geolocatorService.requestPermision();
    state = switch (result) {
      Right(value: final permission) => await _newStateFromPermission(
          permission,
        ),
      Left(value: final exception) => GeolocatorState.error(
          message: exception.toString(),
        ),
    };
  }

  Future<GeolocatorState> _newStateFromPermission(
    LocationPermissionStatus permission,
  ) async {
    if (permission == LocationPermissionStatus.permitted) {
      state = const GeolocatorState.locating();
      final result = await _geolocatorService.location();
      return switch (result) {
        Right(value: final location) => GeolocatorState.localited(
            location: location,
          ),
        Left(value: final exceptio) => GeolocatorState.error(
            message: exceptio.toString(),
          ),
      };
    }
    return GeolocatorState.deneid(status: permission);
  }
}
