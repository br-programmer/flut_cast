import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/features/features.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchCitiesTextField extends HookConsumerWidget {
  const SearchCitiesTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final hasFocus = useValueNotifier(false);
    final query = useValueNotifier('');
    final focusNode = useFocusNode();
    ref.listen(
      StateNotifiers.searchFocus,
      (previous, next) {
        if (!next) {
          controller.clear();
          focusNode.unfocus();
          hasFocus.value = false;
          query.value = '';
        }
      },
    );

    return SliverPersistentHeader(
      pinned: true,
      delegate: FCPinnedPersistenHeaderDelegate(
        child: ColoredBox(
          color: context.theme.scaffoldBackgroundColor,
          child: FCSearchTextField(
            focusNode: focusNode,
            hasFocus: hasFocus,
            controller: controller,
            query: query,
            hint: context.texts.cities.searchCity,
            cancelText: context.texts.cities.cancel,
            onFocus: ref.read(StateNotifiers.searchFocus.notifier).change,
            onChanged: ref.read(search.notifier).search,
          ),
        ),
        extent: 48,
      ),
    );
  }
}
