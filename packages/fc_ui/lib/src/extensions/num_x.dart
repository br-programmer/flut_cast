extension NunX on num {
  DateTime get fromEpoch => DateTime.fromMillisecondsSinceEpoch(
        toInt() * 1000,
        isUtc: true,
      ).toLocal();
}
