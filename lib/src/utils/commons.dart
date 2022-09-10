import 'package:intl/intl.dart';
class Commons{

  static getDate(){
    return DateFormat('dd/MM/yy').format(DateTime.now());
  }

  static String getTime(){
   return DateFormat('kk:mm').format(DateTime.now());
  }

}