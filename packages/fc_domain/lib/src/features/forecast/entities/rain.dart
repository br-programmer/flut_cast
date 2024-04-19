import 'package:freezed_annotation/freezed_annotation.dart';

part 'rain.freezed.dart';
part 'rain.g.dart';

@freezed
class Rain with _$Rain {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Rain({double? the1H}) = _Rain;

  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);
}
