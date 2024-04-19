// ignore_for_file: prefer_asserts_with_message, parameter_assignments

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:fc_local_storage/fc_local_storage.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

/// Random bytes generator
Uint8List _randBytes(int length) {
  final random = Random.secure();
  return Uint8List.fromList(
    List<int>.generate(
      length,
      (i) => random.nextInt(256),
    ),
  );
}

/// Generate an encryption password based on a user input password
///
/// It uses MD5 which generates a 16 bytes blob, size needed for Salsa20
Uint8List _generateEncryptPassword(String password) {
  final blob = Uint8List.fromList(md5.convert(utf8.encode(password)).bytes);
  assert(blob.length == 16);
  return blob;
}

/// Salsa20 based encoder
class _EncryptEncoder extends Converter<Object?, String> {
  _EncryptEncoder(this.salsa20);
  final Salsa20 salsa20;

  @override
  String convert(dynamic input) {
    // Generate random initial value
    final iv = _randBytes(8);
    final ivEncoded = base64.encode(iv);
    assert(ivEncoded.length == 12);

    // Encode the input value
    final encoded = Encrypter(salsa20)
        .encrypt(
          json.encode(input),
          iv: IV(iv),
        )
        .base64;

    // Prepend the initial value
    return '$ivEncoded$encoded';
  }
}

/// Salsa20 based decoder
class _EncryptDecoder extends Converter<String, Object?> {
  _EncryptDecoder(this.salsa20);
  final Salsa20 salsa20;

  @override
  dynamic convert(String input) {
    // Read the initial value that was prepended
    assert(input.length >= 12);
    final iv = base64.decode(input.substring(0, 12));

    // Extract the real input
    input = input.substring(12);

    // Decode the input
    final decoded = json.decode(
      Encrypter(salsa20).decrypt64(
        input,
        iv: IV(iv),
      ),
    );
    if (decoded is Map) {
      return decoded.cast<String, Object?>();
    }
    return decoded;
  }
}

class _EncryptCodec extends Codec<Object?, String> {
  _EncryptCodec(Uint8List passwordBytes) {
    final salsa20 = Salsa20(Key(passwordBytes));
    _encoder = _EncryptEncoder(salsa20);
    _decoder = _EncryptDecoder(salsa20);
  }
  late _EncryptEncoder _encoder;
  late _EncryptDecoder _decoder;

  @override
  Converter<String, Object?> get decoder => _decoder;

  @override
  Converter<Object?, String> get encoder => _encoder;
}

SembastCodec getEncryptSembastCodec({required String password}) => SembastCodec(
      signature: 'encrypt',
      codec: _EncryptCodec(
        _generateEncryptPassword(password),
      ),
    );

class EncryptDbService {
  EncryptDbService(
    this._dbPath,
    this._secureStorage,
    this._databaseFactory,
  ) {
    _secureStorage.read(key: 'db').then(
          (value) => _defaultKey = value,
        );
  }

  final DatabaseFactory _databaseFactory;
  final SecureStorageService _secureStorage;
  final String _dbPath;
  String? _defaultKey;

  Future<Database> openDatabase() async {
    var key = await _secureStorage.read(key: 'db');
    if (key == null) {
      key = const Uuid().v4();
      _secureStorage.write(key: 'db', value: key);
    }
    if (_defaultKey != null && key != _defaultKey) {
      await deleteDatabase();
    }

    return _databaseFactory.openDatabase(
      _dbPath,
      codec: getEncryptSembastCodec(password: key),
    );
  }

  Future<void> deleteDatabase() async {
    _defaultKey = null;
    await _databaseFactory.deleteDatabase(_dbPath);
  }
}
