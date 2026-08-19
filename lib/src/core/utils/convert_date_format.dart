import 'package:intl/intl.dart';

String convertDateFormat(String inputDate) {
  try {
    final inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss a');
    final outputFormat = DateFormat('dd MMM yyyy');
    final date = inputFormat.parse(inputDate);
    return outputFormat.format(date);
  } catch (e) {
    return inputDate;
  }
}
