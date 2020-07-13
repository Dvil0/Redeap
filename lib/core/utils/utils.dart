import 'package:intl/intl.dart';

class Utils {

  static String convertToDate( int millis ) {
    var date = DateTime.fromMicrosecondsSinceEpoch( (millis)*1000 );
    var format = DateFormat.yMd().add_jm().format( date );
    return format;
  }
}
