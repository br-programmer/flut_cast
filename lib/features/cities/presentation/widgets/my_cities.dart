import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/features/features.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyCities extends ConsumerWidget {
  const MyCities({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCities = ref.watch(citiesNotifier).cities;
    return SliverList.separated(
      itemBuilder: (_, index) => MyCity(
        city: myCities[index],
        index: index,
      ),
      separatorBuilder: (context, index) => gap8,
      itemCount: myCities.length,
    );
  }
}
