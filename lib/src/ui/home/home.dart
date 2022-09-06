import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_new/src/bloc/theme/theme_cubit.dart';
import 'package:todo_app_new/src/repo/db/hive_string.dart';
import 'package:todo_app_new/src/repo/db/my_db.dart';
import 'package:todo_app_new/src/ui/add_todo/add_todo.dart';
import 'package:todo_app_new/src/ui/all_todos/all_todo.dart';
import 'package:todo_app_new/src/ui/dashboard/dashboard.dart';
import 'package:todo_app_new/src/ui/setting/setting.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> widgetsList = [
    AddTodo(),
    AllTodos(),
    Dashboard(),
    Setting(),
    Container(
      child: Text("Demo"),
    ),
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    bool themeMode = false;
    // MyDb().openBox().then((value) {
    //   themeMode = value.get(HiveString.themeMode);
    // });
    // context.read<ThemeCubit>().toggleSwitch(themeMode);
    return Scaffold(
      body: widgetsList[index],
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting'),
          ],
          currentIndex: index,
          onTap: (value) {
            setState(() {
              if (value == 2) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Setting()));
              } else {
                index = value;
              }
            });
          }),
    );
  }
}
