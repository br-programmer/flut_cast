import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlutCast extends HookConsumerWidget {
  const FlutCast({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return FCCloseKeyboard(
      app: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        debugShowCheckedModeBanner: false,
        routeInformationProvider: router.routeInformationProvider,
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: FCTheme.dark,
        builder: (context, child) {
          final brightness = context.theme.brightness;
          final style = SystemUiOverlayStyle(statusBarBrightness: brightness);
          SystemChrome.setSystemUIOverlayStyle(style);
          return child!;
        },
        title: 'Flut Cast',
      ),
    );
  }
}
