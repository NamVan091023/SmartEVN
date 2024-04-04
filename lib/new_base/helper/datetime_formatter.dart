import 'package:intl/intl.dart';

class DateTimeFormater {
  /// Dùng để hiển thị
  static String dateFormatVi = "dd/MM/yyyy";
  static String dateTimeFormatVi = "dd/MM/yyyy HH:mm:ss";
  static String dateTimeHour = "HH:mm dd/MM";
  static String dateTime = "HH:mm";

  /// Format date from server và to server;
  static String dateTimeFormat = "yyyy-MM-dd";
  static String dateTimeFormatNormal = "yyyy-MM-dd HH:mm:ss";
  static String fullDateTimeFormat = "yyyy-MM-dd'T'hh:mm:ss.SSSZ";
  static String fullDateTimeKPI = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
}

extension DateTimeExtension on DateTime {
  String toStringWith(String format) {
    String formattedDate = DateFormat(format).format(this);
    return formattedDate;
  }

  String customOnlyDate({String format = 'dd/MM/yyyy'}) {
    try {
      return toStringWith(format);
    } catch (_) {
      return '';
    }
  }
}
