class DateUtilsHelper {
  /// 🔹 Saat, dakika, saniye bilgisini sıfırlar
  /// 🔹 Firestore sorgularında aynı günün her zaman eşleşmesini sağlar
  static DateTime normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// 🔹 Haftanın pazartesini döner
  static DateTime startOfWeek(DateTime date) {
    final normalized = normalize(date);
    return normalized.subtract(Duration(days: normalized.weekday - 1));
  }

  /// 🔹 Haftanın pazarını döner
  static DateTime endOfWeek(DateTime date) {
    return startOfWeek(date).add(const Duration(days: 6));
  }

  /// 🔹 Tarihi "8 December" gibi stringe çevirir
  static String formatDayMonth(DateTime date) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${date.day} ${months[date.month]}';
  }

  /// 🔹 "8 Dec - 14 Dec Schedule" başlığı üretir
  static String weekTitle(DateTime date) {
    final monday = startOfWeek(date);
    final sunday = endOfWeek(date);

    return '${formatDayMonth(monday)} - ${formatDayMonth(sunday)} Schedule';
  }

  static String buildSlotId(DateTime date, String timeRange) {
    final day = date.toIso8601String().split('T')[0]; // 2026-01-12

    final safeTime = timeRange
        .replaceAll(':', '') // 8:00 → 800
        .replaceAll(' ', '') // boşluk sil
        .replaceAll('-', '_'); // 800-1000 → 800_1000

    return "${day}_$safeTime";
  }
}
