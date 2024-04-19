import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/features/features.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CitiesList extends ConsumerWidget {
  const CitiesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: edgeInsetsH20,
      sliver: switch (ref.watch(search)) {
        SearchInitialState() => const MyCities(),
        _ => const SearchResult(),
      },
    );
  }
}
