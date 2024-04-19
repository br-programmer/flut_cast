enum Environment {
  dev(),
  staging(),
  prod();

  const Environment();

  bool get enableLogging => this != Environment.prod;
  String get apiKey => const String.fromEnvironment(
        'apiKey',
        defaultValue: 'f26b3b02fb1f685997074a5143b82e44',
      );
  String get baseUrl => const String.fromEnvironment(
        'baseUrl',
        defaultValue: 'http://api.openweathermap.org',
      );
  String get imageUrl => const String.fromEnvironment(
        'imageUrl',
        defaultValue: 'https://openweathermap.org/img/wn',
      );
}
