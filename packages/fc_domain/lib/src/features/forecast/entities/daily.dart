import 'package:fc_domain/fc_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily.freezed.dart';
part 'daily.g.dart';

@freezed
class Daily with _$Daily {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Daily({
    required int dt,
    required int sunrise,
    required int sunset,
    required int moonrise,
    required int moonset,
    double? moonPhase,
    required String summary,
    required Temp temp,
    FeelsLike? feelsLike,
    required int pressure,
    required int humidity,
    double? dewPoint,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    @Default([]) List<Weather> weather,
    required int clouds,
    required double pop,
    required double uvi,
    double? rain,
  }) = _Daily;

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);
}
