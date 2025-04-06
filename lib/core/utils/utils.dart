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
}
