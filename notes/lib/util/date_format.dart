class DateFormat {
  static String format(DateTime datetime) {
    return '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')} ${datetime.hour.toString().padLeft(2, '0')}-${datetime.minute.toString().padLeft(2, '0')}';
  }

  static String formatFileName(DateTime datetime) {
    return format(datetime).replaceAll(' ', '_');
  }
}