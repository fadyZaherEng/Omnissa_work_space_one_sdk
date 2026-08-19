import 'package:intl/intl.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/di/data_layer_injector.dart';

String formatDate(String date) {
  String formattedDate = "";
  try {
    DateTime originalDate = DateTime.parse(date).toLocal();
    formattedDate = DateFormat('d MMM y').format(originalDate);
  } catch (e) {
    formattedDate = "";
  }
  return formattedDate;
}

String convertTimestampToDateFormat(String timestamp) {
  try {
    if (timestamp.isEmpty) return '';
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDate = DateFormat('d MMM y').format(dateTime);
    return formattedDate;
  } catch (e) {
    return DateFormat('d MMM y').format(DateTime.now());
  }
}

String convertTimestampToDateIntoFormat(String timestamp) {
  String myFormat =
      GetLanguageUseCase(injector())() == "ar" ? 'd-M-yyyy' : 'yyyy-M-d';
  try {
    if (timestamp.isEmpty) return '';
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDate = DateFormat(myFormat).format(dateTime);
    return formattedDate;
  } catch (e) {
    return DateFormat(myFormat).format(DateTime.now());
  }
}

String convertTimestampToDateIntoFormatDelegation(String timestamp) {
  String myFormat = "yyyy-M-d";
  try {
    if (timestamp.isEmpty) return '';
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDate = DateFormat(myFormat).format(dateTime);
    return formattedDate;
  } catch (e) {
    return DateFormat(myFormat).format(DateTime.now());
  }
}

String covertDateTimeToLowerCase(String dateTime) {
  final DateFormat formatter = DateFormat('h:mm a');
  String formatted = formatter.format(
      dateTime == "" ? DateTime.now() : convertStringToDateFormat(dateTime));
  return formatted.replaceAll('AM', 'am').replaceAll('PM', 'pm');
}

DateTime convertStringToDateFormat(String date) {
  return DateTime.parse(date);
}
