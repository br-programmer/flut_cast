import 'package:freezed_annotation/freezed_annotation.dart';

part 'feels_like.freezed.dart';
part 'feels_like.g.dart';

@freezed
class FeelsLike with _$FeelsLike {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FeelsLike({
    required double day,
    required double night,
    required double eve,
    required double morn,
  }) = _FeelsLike;

  factory FeelsLike.fromJson(Map<String, dynamic> json) =>
      _$FeelsLikeFromJson(json);
}
