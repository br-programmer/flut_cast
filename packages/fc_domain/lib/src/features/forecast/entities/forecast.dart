import 'package:fc_domain/fc_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forecast.freezed.dart';
part 'forecast.g.dart';

@freezed
class Forecast with _$Forecast {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Forecast({
    required double lat,
    required double lon,
    required String timezone,
    required int timezoneOffset,
    required Hourly current,
    @Default([]) List<Hourly> hourly,
    @Default([]) List<Daily> daily,
  }) = _Forecast;

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
}

extension ForecastX on Forecast {
  List<Hourly> get hourlies {
    if (hourly.length > 24) {
      return hourly.take(24).toList();
    }
    return hourly;
  }
}
