import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_new/src/bloc/add_todo/add_todo_bloc.dart';
import 'package:todo_app_new/src/bloc/theme/theme_cubit.dart';
import 'package:todo_app_new/src/repo/db/hive_string.dart';
import 'package:todo_app_new/src/repo/db/my_db.dart';
import 'package:todo_app_new/src/repo/repository/add_todo_repository.dart';
import 'package:todo_app_new/src/ui/home/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = false;
    MyDb().openBox().then((value) {
      print(value.values);
      isDarkTheme = value.get(HiveString.themeMode);
    });
    return MultiBlocProvider(
        providers: [
          BlocProvider<AddTodoBloc>(
            create: (BuildContext context) =>
                AddTodoBloc(AddTodoRepositoryImp()),
            // child: Home(),
          ),
          BlocProvider<ThemeCubit>(
            create: (BuildContext context) => ThemeCubit(LightThemeState(isDarkTheme?false:true
            )),
          )
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (BuildContext context, state) {
            if (state is DarkThemeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.dark(),
                home: const Home(),
              );
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light(),
                home: const Home(),
              );
            }
          },
        ));
  }
}
