import 'package:flut_cast/i18n/translations.g.dart';

extension NumX on num {
  String get phase => switch (this) {
        >= .25 || < .5 => texts.forecast.firstQuarterMoon,
        >= .5 || < .75 => texts.forecast.fullMoon,
        >= .75 || < 1 => texts.forecast.lastQuarterMoon,
        _ => texts.forecast.newMoon,
      };

  String get title => switch (this) {
        0 || 1 => texts.forecast.newMoon,
        >= .5 && < .75 => texts.forecast.fullMoon,
        _ => texts.forecast.waxingMoon,
      };

  String get indiceUv => switch (this) {
        < 3 => texts.forecast.low,
        >= 3 && < 6 => texts.forecast.moderate,
        >= 6 && < 8 => texts.forecast.high,
        _ => texts.forecast.veryHigh,
      };
}
