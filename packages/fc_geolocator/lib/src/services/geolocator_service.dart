import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';
import 'package:geolocator/geolocator.dart';

// FutureEither<Exception, LocationPermissionStatus> requestPermision()
// FutureEither<Exception, Location> location()
// FutureEither<Exception, bool> openSettings()

class GeolocatorService {
  FutureEither<Exception, LocationPermissionStatus> requestPermision() async {
    try {
      final permission = await Geolocator.checkPermission();
      final status = _checkPermission(permission);
      if (status == LocationPermissionStatus.permitted) {
        return Either.right(LocationPermissionStatus.permitted);
      }
      final permissionResult = await Geolocator.requestPermission();
      return Either.right(_checkPermission(permissionResult));
    } catch (_) {
      return Either.left(Exception(_));
    }
  }

  FutureEither<Exception, Location> location() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      return Either.right(Location(
        lat: position.latitude,
        lon: position.longitude,
      ));
    } catch (_) {
      return Either.left(Exception(_));
    }
  }

  FutureEither<Exception, bool> openSettings() async {
    try {
      final open = await Geolocator.openLocationSettings();
      return Either.right(open);
    } catch (_) {
      return Either.left(Exception(_));
    }
  }

  LocationPermissionStatus _checkPermission(LocationPermission permission) {
    return switch (permission) {
      LocationPermission.denied => LocationPermissionStatus.denied,
      LocationPermission.deniedForever =>
        LocationPermissionStatus.deniedForever,
      LocationPermission.whileInUse => LocationPermissionStatus.permitted,
      LocationPermission.always => LocationPermissionStatus.permitted,
      LocationPermission.unableToDetermine =>
        LocationPermissionStatus.unableToDetermine,
    };
  }
}
