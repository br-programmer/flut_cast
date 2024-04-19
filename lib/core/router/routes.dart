class Routes {
  const Routes._({required this.name, required this.path});
  final String name;
  final String path;

  static Routes get cities => const Routes._(
        name: 'cities',
        path: '/cities',
      );

  static Routes get search => const Routes._(
        name: 'search',
        path: '/search',
      );

  static Routes get forecast => const Routes._(
        name: 'forecast',
        path: '/',
      );
}
