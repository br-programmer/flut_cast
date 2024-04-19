import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/features/features.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CitiesScreen extends StatelessWidget {
  const CitiesScreen._();

  static Page<T?> pageBuilder<T>(BuildContext _, GoRouterState __) {
    return CustomTransitionPage(
      child: const CitiesScreen._(),
      transitionsBuilder: (
        BuildContext _,
        Animation<double> animation,
        Animation<double> __,
        Widget child,
      ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _Cities());
  }
}

class _Cities extends StatefulHookConsumerWidget {
  const _Cities();

  @override
  ConsumerState<_Cities> createState() => _CitiesState();
}

class _CitiesState extends ConsumerState<_Cities> {
  late final controller = ScrollController()..addListener(listener);
  var ignoreScrool = false;

  void listener() {
    if (ignoreScrool) return;
    final percent = (controller.offset / 48).clamp(0, 2).toDouble();
    ref.read(StateNotifiers.scrollPercent.notifier).change(percent);
  }

  @override
  void dispose() {
    controller
      ..removeListener(listener)
      ..dispose();
    super.dispose();
  }

  Future<void> animateTo(
    double offset, {
    required Duration duration,
    required Curve curve,
  }) async {
    ignoreScrool = true;
    await controller.animateTo(offset, duration: duration, curve: curve);
    ignoreScrool = false;
  }

  void listen(bool? previous, bool next) {
    if (next) {
      animateTo(48, duration: duration175ms, curve: Curves.decelerate);
    } else {
      animateTo(0, duration: duration150ms, curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(StateNotifiers.searchFocus, listen);
    return CustomScrollView(
      controller: controller,
      slivers: [
        const CitiesAppBar(),
        const WeatherText(),
        gap4.toSliver,
        const SearchCitiesTextField(),
        gap4.toSliver,
        const CitiesList(),
      ],
    );
  }
}
