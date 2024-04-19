import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/features/features.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForecastScreen extends StatefulHookConsumerWidget {
  const ForecastScreen._(this.index);
  final int index;

  static Page<T?> pageBuilder<T>(BuildContext _, GoRouterState state) {
    final extra = state.extra! as Map<String, dynamic>;
    return CustomTransitionPage(
      child: ForecastScreen._(extra['index'] as int),
      transitionsBuilder: (
        BuildContext _,
        Animation<double> animation,
        Animation<double> __,
        Widget child,
      ) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  @override
  ConsumerState<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends ConsumerState<ForecastScreen> {
  late final myCities = ref.watch(citiesNotifier).cities;
  late final controller = PageController(initialPage: widget.index);

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(StateNotifiers.currentPage);
    final currentCity = myCities[currentPage];
    final forecast = ref.watch(forecastNotifier(currentCity)).forecast;
    final weather = forecast?.current.weather.first;
    final background = weather?.background;
    return Scaffold(
      body: Hero(
        tag: currentCity.id!,
        child: Material(
          type: MaterialType.transparency,
          child: FCGradient(
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedSwitcher(
                  duration: duration1800ms,
                  child: SizedBox.expand(
                    child: background?.image(fit: BoxFit.cover),
                  ),
                ),
                PageView.builder(
                  controller: controller,
                  onPageChanged:
                      ref.read(StateNotifiers.currentPage.notifier).change,
                  itemBuilder: (_, index) => PageViewItem(
                    city: myCities[index],
                  ),
                  itemCount: myCities.length,
                ),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: const ForecastBottomBar(),
    );
  }
}
