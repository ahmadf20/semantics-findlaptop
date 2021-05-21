import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  filter: null,
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
  output: null,
);

class ErrorMessage {
  static String general = 'Terjadi kesalahan';
  static String connection = 'Kesalahan jaringan';
}

String formatNumber(dynamic number, {local}) {
  final format = NumberFormat("#,###.##", local ?? "id");
  return format.format(double.tryParse(number.toString()) ?? 0);
}
