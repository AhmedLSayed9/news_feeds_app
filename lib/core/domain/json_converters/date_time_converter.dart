import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class DateFormatConverter implements JsonConverter<DateTime, String> {
  const DateFormatConverter.yMd([this._pattern = 'dd/MM/yyyy']);

  final String _pattern;

  @override
  DateTime fromJson(String json) => DateFormat(_pattern).parse(json);

  @override
  String toJson(DateTime object) => DateFormat(_pattern).format(object);
}
