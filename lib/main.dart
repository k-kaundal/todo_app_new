import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_new/src/config/observer/app_bloc_observer.dart';
import 'package:todo_app_new/src/my_app.dart';
import 'package:todo_app_new/src/repo/db/my_db.dart';
import 'package:todo_app_new/src/utils/shared_pref.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Hive.init('/',backendPreference: HiveStorageBackendPreference.native);
  // Open the peopleBox
  // await Hive.openBox('todo');
  SharedPref().prefInit();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // MyDb().hiveInit();
  BlocOverrides.runZoned(() => runApp(const MyApp()),
      blocObserver: AppBlocObserver());
}
