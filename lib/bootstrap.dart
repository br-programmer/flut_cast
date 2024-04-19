import 'dart:async';
import 'dart:developer';

import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

Future<void> bootstrap(Environment env) async {
  final enableLogging = env.enableLogging;
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final appDir = await getApplicationSupportDirectory();
      LocaleSettings.useDeviceLocale();
      GoRouter.optionURLReflectsImperativeAPIs = true;
      final flutCastApp = TranslationProvider(
        child: ProviderScope(
          overrides: overrides(env, appDir.path),
          child: const FlutCast(),
        ),
      );
      runApp(flutCastApp);
      FlutterError.onError = (details) {
        if (enableLogging) {
          log(details.exceptionAsString(), stackTrace: details.stack);
        }
      };
    },
    (error, stack) {
      if (enableLogging) {
        log(error.toString(), stackTrace: stack);
      }
    },
  );
}
