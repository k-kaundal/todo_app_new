import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_new/src/bloc/add_todo/add_todo_bloc.dart';
import 'package:todo_app_new/src/bloc/get_todo/get_todo_bloc.dart';
import 'package:todo_app_new/src/bloc/navigation/navigation_bloc.dart';
import 'package:todo_app_new/src/bloc/theme/theme_cubit.dart';
import 'package:todo_app_new/src/bloc/update_todo/update_todo_bloc.dart';
import 'package:todo_app_new/src/repo/db/hive_string.dart';
import 'package:todo_app_new/src/repo/db/my_db.dart';
import 'package:todo_app_new/src/repo/repository/add_todo_repository.dart';
import 'package:todo_app_new/src/repo/repository/get_todo_repository.dart';
import 'package:todo_app_new/src/repo/repository/todo_repository.dart';
import 'package:todo_app_new/src/ui/all_todos/all_todo.dart';
import 'package:todo_app_new/src/ui/home/home.dart';

import 'bloc/todo/todo_bloc.dart';

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
          BlocProvider<NavigationBloc>(
            create: (BuildContext context) =>
                NavigationBloc(),
            // child: Home(),
          ),
          BlocProvider<GetTodoBloc>(
            create: (BuildContext context) =>
                GetTodoBloc(GetTodoRepositoryImp()),
            // child: Home(),
          ),
          BlocProvider<ThemeCubit>(
            create: (BuildContext context) => ThemeCubit(LightThemeState(isDarkTheme?false:true
            )),
          ),
          BlocProvider<TodoBloc>(
            create: (context) => TodoBloc(TodoRepositoryImp()),
          ),
          BlocProvider<UpdateTodoBloc>(
            create: (context) => UpdateTodoBloc(TodoRepositoryImp())
          ),
        ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          useMaterial3: true
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true
        ),
        home: const Home(),
      ),

        // child: BlocBuilder<ThemeCubit, ThemeState>(
        //   builder: (BuildContext context, state) {
        //     if (state is DarkThemeState) {
        //       return MaterialApp(
        //         debugShowCheckedModeBanner: false,
        //         theme: ThemeData.dark(
        //           useMaterial3: true
        //         ),
        //         home: const Home(),
        //       );
        //     } else {
        //       return MaterialApp(
        //         debugShowCheckedModeBanner: false,
        //         theme: ThemeData.light(
        //           useMaterial3: true
        //         ),
        //         home: const Home(),
        //       );
        //     }
        //   },
        // )
    );
  }
}
