import 'package:freezed_annotation/freezed_annotation.dart';

part 'forecast_request.freezed.dart';
part 'forecast_request.g.dart';

@freezed
class ForecastRequest with _$ForecastRequest {
  factory ForecastRequest({
    required double lat,
    required double lon,
    @Default('alerts') String exclude,
  }) = _ForecastRequest;

  factory ForecastRequest.fromJson(Map<String, dynamic> json) =>
      _$ForecastRequestFromJson(json);
}
