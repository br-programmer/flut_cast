import 'package:flut_cast/core/core.dart';
import 'package:riverpod/riverpod.dart';

class StateNotifiers {
  const StateNotifiers._();
  static final scrollPercent =
      StateNotifierProvider<ValueProvider<double>, double>(
    (ref) => ValueProvider(0),
  );

  static final searchFocus = StateNotifierProvider<ValueProvider<bool>, bool>(
    (ref) => ValueProvider(false),
  );

  static final currentPage = StateNotifierProvider<ValueProvider<int>, int>(
    (ref) => ValueProvider(0),
  );
}
