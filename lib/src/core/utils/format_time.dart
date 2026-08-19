String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
}

int compareDates(String? a, String? b) {
  final dateA = _parseDate(a);
  final dateB = _parseDate(b);

  if (dateA == null && dateB == null) return 0;
  if (dateA == null) return -1;
  if (dateB == null) return 1;

  return dateA.compareTo(dateB);
}

DateTime? _parseDate(String? dateString) {
  if (dateString == null || dateString.trim().isEmpty) return null;
  try {
    return DateTime.parse(dateString);
  } catch (_) {
    return null;
  }
}
