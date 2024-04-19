import 'package:fc_domain/src/features/search/entities/local_names.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city.freezed.dart';
part 'city.g.dart';

@freezed
class City with _$City {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory City({
    String? id,
    required String name,
    required double lat,
    required double lon,
    required String country,
    String? state,
    LocalNames? localNames,
    @Default(false) bool myLocation,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
