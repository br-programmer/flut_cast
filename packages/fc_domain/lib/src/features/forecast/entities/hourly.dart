import 'package:fc_domain/fc_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourly.freezed.dart';
part 'hourly.g.dart';

@freezed
class Hourly with _$Hourly {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Hourly({
    required int dt,
    int? sunrise,
    int? sunset,
    required double temp,
    double? feelsLike,
    required int pressure,
    required int humidity,
    double? dewPoint,
    required double uvi,
    required int clouds,
    int? visibility,
    double? windSpeed,
    int? windDeg,
    required List<Weather> weather,
    double? windGust,
    double? pop,
    Rain? rain,
  }) = _Hourly;

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);
}
