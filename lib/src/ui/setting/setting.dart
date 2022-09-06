import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_new/src/bloc/theme/theme_cubit.dart';
import 'package:todo_app_new/src/repo/db/hive_string.dart';
import 'package:todo_app_new/src/repo/db/my_db.dart';
import 'package:todo_app_new/src/utils/shared_pref.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isDarkTheme = false;
  SharedPref pref = SharedPref();

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  getTheme() async {
    SharedPreferences preferences = await pref.prefInit();
    // preferences.setBool(pref.themeMode, value);
    isDarkTheme = preferences.getBool(pref.themeMode)!;
    print(isDarkTheme);
    // = MyDb().box.;
  }

  setTheme() async {
    SharedPreferences preferences = await pref.prefInit();
    preferences.setBool(pref.themeMode, isDarkTheme);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getTheme();
    // MyDb().openBox().then((value) {
    //   print(value.values);
    //   isDarkTheme = value.get(HiveString.themeMode);
    //   print(value.get(HiveString.themeMode));
    // });
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark Mode'),
                Switch(
                    value: isDarkTheme,
                    onChanged: (bool value) {
                      setState(() {
                        isDarkTheme = value;
                        setTheme();
                        // MyDb().openBox().then((value) {
                        //   value.put(HiveString.themeMode, value);
                        // });
                        context.read<ThemeCubit>().toggleSwitch(value);
                      });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
