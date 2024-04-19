import 'dart:core';

extension IterableX<E> on Iterable<E> {
  /// Shortcut for `map((E e) => e).toList()`.
  List<T> mapList<T>(T Function(E element) f) {
    return map(f).toList();
  }

  /// Shortcut for `where((E e) => e).toList()`.
  List<E> whereList<T>(bool Function(E element) f) {
    return where(f).toList();
  }

  E? firstWhereOrNull(bool Function(E element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
