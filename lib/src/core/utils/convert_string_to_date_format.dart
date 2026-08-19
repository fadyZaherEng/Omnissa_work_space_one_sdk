DateTime convertStringToDateFormat(String date) {
  return DateTime.parse(date);
}

bool isMoreThenOrEqualDate(String date1, String date2) {
  final d1 = DateTime.tryParse(date1);
  final d2 = DateTime.tryParse(date2);
  if (d1 == null || d2 == null) return false;

  final d1Only = DateTime(d1.year, d1.month, d1.day);
  final d2Only = DateTime(d2.year, d2.month, d2.day);

  return d1Only.isAfter(d2Only) || d1Only.isAtSameMomentAs(d2Only);
}

bool isLessThenDate(String date1, String date2) {
  final d1 = DateTime.tryParse(date1);
  final d2 = DateTime.tryParse(date2);
  if (d1 == null || d2 == null) return false;

  final d1Only = DateTime(d1.year, d1.month, d1.day);
  final d2Only = DateTime(d2.year, d2.month, d2.day);

  return d1Only.isBefore(d2Only);
}
