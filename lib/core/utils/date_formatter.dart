abstract final class DateFormatter {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static String date(DateTime dt) {
    return '${_months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  static String time(DateTime dt) {
    final h      = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m      = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '${h.toString().padLeft(2, '0')}:$m $period';
  }

  static String dateTime(DateTime dt) => '${date(dt)}  ·  ${time(dt)}';
}
