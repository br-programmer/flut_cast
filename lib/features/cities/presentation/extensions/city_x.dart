import 'package:fc_domain/fc_domain.dart';
import 'package:flut_cast/i18n/translations.g.dart';

extension CityX on City {
  String get title {
    late final String name;
    switch (LocaleSettings.currentLocale.languageCode) {
      case 'es':
        name = localNames?.es ?? this.name;
      default:
        name = localNames?.en ?? this.name;
    }
    return '$name, $country';
  }

  String get city {
    switch (LocaleSettings.currentLocale.languageCode) {
      case 'es':
        return localNames?.es ?? name;
      default:
        return localNames?.en ?? name;
    }
  }
}
