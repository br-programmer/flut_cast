import 'package:fc_domain/fc_domain.dart';
import 'package:fc_ui/fc_ui.dart';

extension WeatherX on Weather {
  ShaderData? get shaderData => switch (main.toLowerCase()) {
        'clouds' => (image: null, shaderName: 'clouds'),
        'clear' => (image: null, shaderName: 'clear_sky'),
        'drizzle' => (
            image: Assets.images.clows.provider(),
            shaderName: 'drizzle',
          ),
        'snow' => (image: null, shaderName: 'snow'),
        'rain' => (image: null, shaderName: 'rain'),
        'thunderstorm' => (image: null, shaderName: 'thunderstorm'),
        _ => null,
      };
}
