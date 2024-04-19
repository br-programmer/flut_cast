import 'package:freezed_annotation/freezed_annotation.dart';

part 'reverse_request.freezed.dart';
part 'reverse_request.g.dart';

@freezed
class ReverseRequest with _$ReverseRequest {
  factory ReverseRequest({
    required double lat,
    required double lon,
    @Default(1) int limit,
  }) = _ReverseRequest;

  factory ReverseRequest.fromJson(Map<String, dynamic> json) =>
      _$ReverseRequestFromJson(json);
}
