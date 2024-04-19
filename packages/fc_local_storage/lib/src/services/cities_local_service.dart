import 'dart:async';
import 'dart:developer';

import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';
import 'package:fc_local_storage/fc_local_storage.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

class CitiesLocalService {
  CitiesLocalService({
    required Future<Database> Function() openDatabase,
    required Future<void> Function() deleteDatabase,
    required StoreRef<String, Json> citiesStore,
    required SecureStorageService storageService,
  })  : _openDatabase = openDatabase,
        _deleteDatabase = deleteDatabase,
        _citiesStore = citiesStore,
        _storageService = storageService;

  final Future<Database> Function() _openDatabase;
  final Future<void> Function() _deleteDatabase;
  final StoreRef<String, Json> _citiesStore;
  final SecureStorageService _storageService;

  Database? _db;
  Completer<void>? _completer;

  Future<void> start() async {
    if (_db != null) {
      return;
    }
    try {
      _completer = Completer();
      _db = await _openDatabase();
      _completer!.complete();
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
    }
  }

  Future<List<City>> cities() async {
    final list = await _citiesStore.find(_db!);
    return list.mapList((e) => City.fromJson(e.value));
  }

  Future<void> setCity(City city) async {
    try {
      await _completer?.future;
      await _citiesStore.record(city.id!).put(_db!, city.toJson(), merge: true);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
    }
  }

  Future<void> deleteCity(String id) async {
    await _citiesStore.delete(
      _db!,
      finder: Finder(filter: Filter.equals('id', id)),
    );
  }

  Future<void> close() async {
    if (_db == null) {
      return;
    }
    await _db!.close();
    _db = null;
  }

  Future<void> deleted() async {
    if (_db == null) {
      return;
    }
    await _storageService.delete(key: 'db');
    await _citiesStore.delete(_db!);
    await _deleteDatabase();
  }

  String get uuid => Uuid().v4();
}
