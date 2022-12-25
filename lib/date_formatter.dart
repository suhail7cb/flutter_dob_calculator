
import 'package:intl/intl.dart';

class AppDateFormatter {
  static DateFormat ddMMYYYYDateFormatter =  DateFormat('dd-MM-yyyy');
  static DateFormat ddMMMYYYYDateFormatter =  DateFormat('E, dd MMM yyyy');

  static DateFormat yyyyMMDDDateFormatter =  DateFormat('yyyy-MM-dd');
  static DateFormat timeFormatter =  DateFormat('kk:mm a');

  static String getFormattedDate({required DateFormat formatter, required DateTime date}) {
    return formatter.format(date);
  }

  static String getFormattedDateFromString({required DateFormat formatter,required String dateInString}) {
    DateTime tempDate =  DateFormat("yyyy-MM-ddThh:mm:ss").parse(dateInString);
    return formatter.format(tempDate);
  }

  static String getFormattedTimeFromString({required DateFormat formatter, required String timeInString}) {
    DateTime tempDate =  DateFormat("hh:mm:ss").parse(timeInString);
    return formatter.format(tempDate);
  }
}