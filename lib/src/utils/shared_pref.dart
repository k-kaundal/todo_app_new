import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  late SharedPreferences pref;

  String themeMode = 'themeMode';

 Future<SharedPreferences> prefInit() async {
    pref = await SharedPreferences.getInstance();
    if(pref.getBool(themeMode) == null){
      pref.setBool(themeMode, true);
    }
    return pref;
  }
}
