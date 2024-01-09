import 'package:intl/intl.dart';

class TimeManager{


  static String? dateTimeToDB(DateTime? dateTime){
    if(dateTime==null){
      return null;
    }
    String date = "";

    date = DateFormat('yyyy-mm-dd hh:mm','es').format(dateTime);
    return date;
  }
}