import 'package:fc_geolocator/fc_geolocator.dart';
import 'package:fc_local_storage/fc_local_storage.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sembast/sembast.dart';

class Services {
  const Services._();
  static final geolocator = Provider<GeolocatorService>(
    (ref) => GeolocatorService(),
  );

  static final encryptDb = Provider<EncryptDbService>(
    (ref) => throw UnimplementedError(),
  );

  static final secureStorage = Provider<SecureStorageService>(
    (ref) => SecureStorageService(),
  );

  static final cities = Provider<CitiesLocalService>(
    (ref) => CitiesLocalService(
      openDatabase: ref.read(encryptDb).openDatabase,
      deleteDatabase: ref.read(encryptDb).deleteDatabase,
      citiesStore: StoreRef('cities'),
      storageService: ref.read(secureStorage),
    ),
  );
}
