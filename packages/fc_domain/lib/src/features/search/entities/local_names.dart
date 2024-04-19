import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_names.freezed.dart';
part 'local_names.g.dart';

@freezed
class LocalNames with _$LocalNames {
  factory LocalNames({String? en, String? es}) = _LocalNames;

  factory LocalNames.fromJson(Map<String, dynamic> json) =>
      _$LocalNamesFromJson(json);
}
