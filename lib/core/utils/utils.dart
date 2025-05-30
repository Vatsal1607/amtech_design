import 'package:intl/intl.dart';

class Utils {
  /// Formats a DateTime string into the 'h:mm a' format (e.g., 9:51 AM).
  static String formatTime(String dateTimeString) {
    try {
      // Parse the DateTime string
      DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
      // Format the time as hh:mm a
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      // Handle invalid DateTime strings gracefully
      return dateTimeString;
    }
  }

  String convertIsoToFormattedDate(String isoDate) {
    try {
      DateTime dateTime =
          DateTime.parse(isoDate).toLocal(); // Convert to local time
      return DateFormat("M/d/yyyy hh:mma").format(dateTime); // Format date
    } catch (e) {
      return "Invalid date"; // Handle errors
    }
  }

  // Dynamic above format
  String convertIsoToFormattedDateDynamic(dynamic isoDate) {
    try {
      DateTime dateTime;

      if (isoDate is DateTime) {
        dateTime = isoDate.toLocal();
      } else if (isoDate is String) {
        dateTime = DateTime.parse(isoDate).toLocal();
      } else {
        return "Invalid date";
      }

      return DateFormat("M/d/yyyy hh:mma").format(dateTime).toLowerCase();
    } catch (e) {
      return "Invalid date";
    }
  }

  // DateFormat: dd/MM/yyyy
  static String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatDateForApi(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatDateToDDMMYYYY(String isoDateString) {
    try {
      final dateTime = DateTime.parse(isoDateString)
          .toLocal(); // Convert to local time if needed
      final formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(dateTime);
    } catch (e) {
      return ''; // Return empty if parsing fails
    }
  }

  // Date format 1st JAN 2025
  static String formatSubscriptionDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString)
          .toLocal(); // Convert to local time if needed

      String day = date.day.toString();
      String month = _monthAbbreviation(date.month);
      String year = date.year.toString();

      String dayWithSuffix = _addDaySuffix(date.day);

      return '$dayWithSuffix $month $year';
    } catch (e) {
      return '';
    }
  }

  static String _addDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  static String _monthAbbreviation(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC'
    ];
    return months[month - 1];
  }

  static String defaultUserId =
      '6820dcd705ec25425b883a23'; // Guest id DEV bhavani
}
