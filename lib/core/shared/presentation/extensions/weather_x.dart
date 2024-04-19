import 'package:fc_domain/fc_domain.dart';
import 'package:fc_ui/fc_ui.dart';

extension WeatherX on Weather {
  AssetGenImage? get background => switch (main.toLowerCase()) {
        'clouds' => Assets.gifs.clouds,
        'clear' => Assets.gifs.clearSky,
        'snow' => Assets.gifs.snow,
        'rain' => Assets.gifs.rain,
        'drizzle' => Assets.gifs.drizzle,
        'thunderstorm' => Assets.gifs.thunderstorm,
        _ => null,
      };
}
