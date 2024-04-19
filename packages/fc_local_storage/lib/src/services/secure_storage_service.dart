import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  factory SecureStorageService() => instance;
  SecureStorageService._internal();
  static final SecureStorageService instance = SecureStorageService._internal();

  static const _storage = FlutterSecureStorage();

  Future<void> write({
    required String key,
    required String value,
  }) =>
      _storage.write(key: key, value: value);

  Future<String?> read({
    required String key,
  }) =>
      _storage.read(key: key);

  Future<Map<String, dynamic>?> readJson({
    required String key,
  }) async {
    final json = await _storage.read(key: key);
    if (json == null) return null;
    return jsonDecode(json) as Map<String, dynamic>;
  }

  Future<void> writeJson({
    required String key,
    required Map<String, dynamic> value,
  }) =>
      _storage.write(key: key, value: jsonEncode(value));

  Future<void> delete({required String key}) => _storage.delete(key: key);

  Future<void> deleteAll() => _storage.deleteAll();

  Future<Map<String, String>> readAll() => _storage.readAll();
}
