import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  static final _now = DateTime.now();
  bool get today => _now.day == day;
  bool get now => _now.hour == hour;

  String dayLetter(String locale) => DateFormat('EEE', locale).format(this);
  String get hourNumber => DateFormat('HH').format(this);
  String get hourComplete => DateFormat('HH:MM').format(this);
}
