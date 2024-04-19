import 'dart:convert';

extension EncondeJson on Map<String, dynamic> {
  String get encode => jsonEncode(this);
}

extension DecodeJson on String {
  Map<String, dynamic> get decode => jsonDecode(this) as Map<String, dynamic>;
}
