import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_request.freezed.dart';
part 'search_request.g.dart';

@freezed
class SearchRequest with _$SearchRequest {
  factory SearchRequest({
    @JsonKey(name: 'q') required String query,
    @Default(10) int limit,
  }) = _SearchRequest;

  factory SearchRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestFromJson(json);
}
