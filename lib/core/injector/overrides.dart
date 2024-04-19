import 'package:fc_local_storage/fc_local_storage.dart';
import 'package:flut_cast/core/core.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sembast/sembast_io.dart';

List<Override> overrides(Environment env, String path) => [
      Providers.enviroment.overrideWithValue(env),
      Services.encryptDb.overrideWith(
        (ref) => EncryptDbService(
          join(path, 'flut_cast.db'),
          ref.read(Services.secureStorage),
          databaseFactoryIo,
        ),
      ),
    ];
