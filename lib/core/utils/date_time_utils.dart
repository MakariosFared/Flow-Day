class DateTimeUtils {
  DateTimeUtils._();

  /// Formats a DateTime as YYYY-MM-DD
  static String formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  /// Formats a DateTime as a human readable date (e.g. "Sep 10, 2026")
  static String formatHumanDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  /// Parses YYYY-MM-DD to local DateTime at midnight
  static DateTime parseDate(String dateStr) {
    final parts = dateStr.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  /// Calculates total minutes after midnight
  static int timeToMinutes(DateTime time) {
    return time.hour * 60 + time.minute;
  }

  /// Constructs a DateTime on [date] with given minutes after midnight
  static DateTime minutesToDateTime(DateTime date, int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return DateTime(date.year, date.month, date.day, hours, mins);
  }

  /// Formats a Duration as a concise string (e.g. "1h 30m", "45m", "2h")
  static String formatDuration(Duration duration) {
    if (duration <= Duration.zero) return '0m';
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${minutes}m';
    }
  }
}
