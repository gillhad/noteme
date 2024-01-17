import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class TimeManager{


  static String? dateTimeToDB(DateTime? dateTime){
    if(dateTime==null){
      return null;
    }
    String date = "";

    date = DateFormat('yyyy-MM-dd hh:mm','es').format(dateTime);
    return date;
  }
  static DateTime? databaseToDateTime(String? dateTime){
    if(dateTime == null){
      return null;
    }
    ///Take care of local time for adding hours
    DateTime date = DateTime.parse(dateTime);
        // .add(const Duration(hours: 1));
    return date;
  }

}