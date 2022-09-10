import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_new/src/bloc/navigation/navigation_bloc.dart';
import 'package:todo_app_new/src/bloc/theme/theme_cubit.dart';
import 'package:todo_app_new/src/repo/db/hive_string.dart';
import 'package:todo_app_new/src/repo/db/my_db.dart';
import 'package:todo_app_new/src/ui/add_todo/add_todo.dart';
import 'package:todo_app_new/src/ui/all_todos/all_todo.dart';
import 'package:todo_app_new/src/ui/dashboard/dashboard.dart';
import 'package:todo_app_new/src/ui/important/important.dart';
import 'package:todo_app_new/src/ui/setting/setting.dart';
import 'package:todo_app_new/src/ui/today_todo/today_todo.dart';
import 'package:todo_app_new/src/ui/todo/todo.dart';
import 'package:todo_app_new/src/ui/todo_type/todo_type.dart';
import 'package:todo_app_new/src/ui/todo_list/todo_list_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> title = [
    'My Day',
    'Important',
    'Planned',
    'Assign to me',
    'Task'
  ];
  List<Widget> widgetsList = [
    // Todo(),
    // AddTodo(),
    TodayTodo(),
    Important(),
    TodoType(),
    Dashboard(),
    AllTodos(),
    TodoListScreen(),
    Container(
      child: Text("Demo"),
    ),
  ];
  int navIndex = 0;
  List newTodoList = [];
  List<NewTodoGroupModel> newTodoGroupList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool themeMode = false;
    // MyDb().openBox().then((value) {
    //   themeMode = value.get(HiveString.themeMode);
    // });
    // context.read<ThemeCubit>().toggleSwitch(themeMode);
    String titleTxt= '';
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(context.read<NavigationBloc>().state.nameOfList.toString()),
          actions: [
            Image.asset('assets/images/happy.png'),
            IconButton(
                onPressed: () {
                  showMenu(
                      context: context,
                      position: RelativeRect.fromDirectional(
                          textDirection: TextDirection.ltr,
                          start: size.width * 0.1,
                          top: size.height * 0.1,
                          end: 0,
                          bottom: 0),
                      items: [
                        PopupMenuItem(onTap: () {}, child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Icon(Icons.settings), Text('Setting')])),
                        PopupMenuItem(child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Icon(Icons.settings), Text('Setting')])),
                        PopupMenuItem(child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Icon(Icons.settings), Text('Setting')])),
                      ]);
                },
                icon: Icon(Icons.more_vert))
          ],
        ),
        drawer: Drawer(
            child: BlocConsumer<NavigationBloc, NavigationState>(
          builder: (BuildContext context, state) {
            return Container(
              height: size.height,
              width: size.width,
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Card(
                                child: Container(
                                  height: 50,
                                  // width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Kamlesh'),
                                  Text('kamlesh@gmail.com'),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        context
                            .read<NavigationBloc>()
                            .add(NavigationItemMyDayClick());
                        setState(() {
                          navIndex = 0;
                          scaffoldKey.currentState!.closeDrawer();
                        });
                      },
                      minLeadingWidth: 10,
                      leading: Icon(Icons.sunny),
                      title: Text('My Day',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      trailing: Text('2'),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          navIndex = 1;
                          scaffoldKey.currentState!.closeDrawer();
                        });
                      },
                      minLeadingWidth: 10,
                      leading: Icon(
                        Icons.star,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Important',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      trailing: Text('2'),
                    ),
                    ListTile(
                      minLeadingWidth: 10,
                      leading: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.green,
                      ),
                      title: Text('Planned',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      trailing: Text('2'),
                    ),
                    ListTile(
                      minLeadingWidth: 10,
                      leading: Icon(
                        Icons.person_outline_rounded,
                        color: Colors.green,
                      ),
                      title: Text('Assigned to me',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      trailing: Text('2'),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          navIndex = 4;
                          scaffoldKey.currentState!.closeDrawer();
                        });
                      },
                      minLeadingWidth: 10,
                      leading: Icon(
                        Icons.task,
                        color: Colors.deepPurple,
                      ),
                      title: Text('Task',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      trailing: Text(
                        '2',
                      ),
                    ),
                    Divider(),
                    ListView(
                        padding: EdgeInsets.only(
                          top: 0,
                        ),
                        shrinkWrap: true,
                        primary: true,
                        children: [
                          ListView.builder(
                            primary: false,
                            // physics: NeverScrollableScrollPhysic(),
                            padding: EdgeInsets.only(
                              top: 0,
                            ),
                            shrinkWrap: true,
                            itemCount: newTodoGroupList.length,
                            itemBuilder: (context, index) {
                              return Column(children: [
                                ListTile(
                                  onTap: () {
                                    setState(() {
                                      newTodoGroupList[index].isOpen =
                                          !newTodoGroupList[index].isOpen;
                                    });
                                  },
                                  minLeadingWidth: 10,
                                  minVerticalPadding: 0,
                                  leading: Icon(
                                    Icons.folder_copy_outlined,
                                    color: Colors.deepPurple,
                                  ),
                                  title: Text(newTodoGroupList[index].name!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  trailing: IconButton(
                                    icon: Icon(newTodoGroupList[0].isOpen
                                        ? Icons.keyboard_arrow_down_outlined
                                        : Icons.keyboard_arrow_right_outlined),
                                    onPressed: () {
                                      setState(() {
                                        newTodoGroupList[index].isOpen =
                                            !newTodoGroupList[index].isOpen;
                                      });
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: newTodoGroupList[index].isOpen,
                                  child: ListView.builder(
                                    primary: false,
                                    padding: EdgeInsets.only(
                                        top: 0, bottom: size.height * 0.1),
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                          onLongPress: () {
                                            // showBottomSheet(
                                            //     context: context,
                                            //     builder: (context) {
                                            //       return Container(
                                            //         height: size.height * 0.2,
                                            //         width: size.width,
                                            //         color: Colors.red,
                                            //       );
                                            //     });
                                            showMenu(
                                                context: context,
                                                position: RelativeRect.fromSize(
                                                    Rect.fromLTWH(
                                                        10,
                                                        size.height * 0.5,
                                                        size.width * 0.05,
                                                        size.height * 0.2),
                                                    size),
                                                items:
                                                    // [
                                                    //     PopupMenuItem(
                                                    //         onTap: () {},
                                                    //         child: Row(
                                                    //           children: [
                                                    //             Icon(Icons.drive_file_move_outlined),
                                                    //             Text("Move to group")
                                                    //           ],
                                                    //         )),
                                                    List.generate(2, (index) {
                                                  return PopupMenuItem(
                                                      child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        newTodoGroupList[0]
                                                            .todoList
                                                            ?.add(
                                                                newTodoList[0]);
                                                        newTodoList.removeAt(0);
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons
                                                            .drive_file_move_outlined),
                                                        Text("Move to group 1")
                                                      ],
                                                    ),
                                                  ));
                                                })
                                                // ]
                                                );
                                          },
                                          onTap: () {
                                            setState(() {
                                              navIndex = 5;
                                              scaffoldKey.currentState!
                                                  .closeDrawer();
                                            });
                                          },
                                          minLeadingWidth: 10,
                                          minVerticalPadding: 0,
                                          leading: Icon(
                                            Icons.list,
                                            color: Colors.deepPurple,
                                          ),
                                          title: Text(
                                              newTodoGroupList[0].todoList![0],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                          trailing: Text('5'));
                                    },
                                  ),
                                ),
                              ]);
                            },
                          ),
                          ListView.builder(
                            primary: false,
                            padding: EdgeInsets.only(
                                top: 0, bottom: size.height * 0.1),
                            shrinkWrap: true,
                            itemCount: newTodoList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  onLongPress: () {
                                    // showBottomSheet(
                                    //     context: context,
                                    //     builder: (context) {
                                    //       return Container(
                                    //         height: size.height * 0.2,
                                    //         width: size.width,
                                    //         color: Colors.red,
                                    //       );
                                    //     });
                                    showMenu(
                                        context: context,
                                        position: RelativeRect.fromSize(
                                            Rect.fromLTWH(
                                                10,
                                                size.height * 0.5,
                                                size.width * 0.05,
                                                size.height * 0.2),
                                            size),
                                        items:
                                            // [
                                            //     PopupMenuItem(
                                            //         onTap: () {},
                                            //         child: Row(
                                            //           children: [
                                            //             Icon(Icons.drive_file_move_outlined),
                                            //             Text("Move to group")
                                            //           ],
                                            //         )),
                                            List.generate(4, (index) {
                                          return PopupMenuItem(
                                              child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                newTodoGroupList[0]
                                                    .todoList
                                                    ?.add(newTodoList[0]);
                                                newTodoList.removeAt(0);
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons
                                                    .drive_file_move_outlined),
                                                Text("Move to group 1")
                                              ],
                                            ),
                                          ));
                                        })
                                        // ]
                                        );
                                  },
                                  onTap: () {
                                    context.read<NavigationBloc>().add(
                                        NavigationItemClick(
                                            index: index + 4,
                                            nameOfList: newTodoList[index]));
                                    setState(() {
                                      navIndex = 5;
                                      scaffoldKey.currentState!.closeDrawer();
                                    });
                                  },
                                  minLeadingWidth: 10,
                                  minVerticalPadding: 0,
                                  leading: Icon(
                                    Icons.list,
                                    color: Colors.deepPurple,
                                  ),
                                  title: Text(newTodoList[index],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  trailing: Text('5'));
                            },
                          ),
                        ]),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin:
                        EdgeInsets.only(bottom: size.height * 0.02, left: 10),
                    height: size.height * 0.08,
                    // color: Colors.red,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  newTodoList.add(
                                      'Untitled list ${newTodoList.length + 1}');
                                  print('Untitled list ${newTodoList.length}');
                                  title.add(
                                      'Untitled list ${newTodoList.length}');
                                  print(title);
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text('New List',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.note_add_outlined),
                              onPressed: () {
                                setState(() {
                                  newTodoGroupList.add(NewTodoGroupModel(
                                      name:
                                          "Untitled group ${newTodoGroupList.length + 1}"));
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            );
          },
          listener: (BuildContext context, Object? state) {},
          //       child: Container(
          //   height: size.height,
          //   width: size.width,
          //   child: Stack(children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           SizedBox(
          //             height: size.height * 0.05,
          //           ),
          //           Container(
          //             height: 50,
          //             child: Row(
          //               children: [
          //                 Expanded(
          //                     flex: 2,
          //                     child: Card(
          //                       child: Container(
          //                         height: 50,
          //                         // width: 30,
          //                         decoration: BoxDecoration(
          //                           borderRadius:
          //                               BorderRadius.all(Radius.circular(60)),
          //                         ),
          //                       ),
          //                     )),
          //                 Expanded(
          //                     flex: 9,
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         Text('Kamlesh'),
          //                         Text('kamlesh@gmail.com'),
          //                       ],
          //                     ))
          //               ],
          //             ),
          //           ),
          //           Divider(),
          //           ListTile(
          //             onTap: () {
          //               setState(() {
          //                 navIndex = 0;
          //                 scaffoldKey.currentState!.closeDrawer();
          //               });
          //             },
          //             minLeadingWidth: 10,
          //             leading: Icon(Icons.sunny),
          //             title: Text('My Day',
          //                 style:
          //                     TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          //             trailing: Text('2'),
          //           ),
          //           ListTile(
          //             onTap: () {
          //               setState(() {
          //                 navIndex = 1;
          //                 scaffoldKey.currentState!.closeDrawer();
          //               });
          //             },
          //             minLeadingWidth: 10,
          //             leading: Icon(
          //               Icons.star,
          //               color: Colors.red,
          //             ),
          //             title: Text(
          //               'Important',
          //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          //             ),
          //             trailing: Text('2'),
          //           ),
          //           ListTile(
          //             minLeadingWidth: 10,
          //             leading: Icon(
          //               Icons.calendar_today_outlined,
          //               color: Colors.green,
          //             ),
          //             title: Text('Planned',
          //                 style:
          //                     TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          //             trailing: Text('2'),
          //           ),
          //           ListTile(
          //             minLeadingWidth: 10,
          //             leading: Icon(
          //               Icons.person_outline_rounded,
          //               color: Colors.green,
          //             ),
          //             title: Text('Assigned to me',
          //                 style:
          //                     TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          //             trailing: Text('2'),
          //           ),
          //           ListTile(
          //             onTap: () {
          //               setState(() {
          //                 navIndex = 4;
          //                 scaffoldKey.currentState!.closeDrawer();
          //               });
          //             },
          //             minLeadingWidth: 10,
          //             leading: Icon(
          //               Icons.task,
          //               color: Colors.deepPurple,
          //             ),
          //             title: Text('Task',
          //                 style:
          //                     TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          //             trailing: Text(
          //               '2',
          //             ),
          //           ),
          //           Divider(),
          //           ListView(
          //               padding: EdgeInsets.only(
          //                 top: 0,
          //               ),
          //               shrinkWrap: true,
          //               primary: true,
          //               children: [
          //                 ListView.builder(
          //                   primary: false,
          //                   // physics: NeverScrollableScrollPhysic(),
          //                   padding: EdgeInsets.only(
          //                     top: 0,
          //                   ),
          //                   shrinkWrap: true,
          //                   itemCount: newTodoGroupList.length,
          //                   itemBuilder: (context, index) {
          //                     return Column(children: [
          //                       ListTile(
          //                         onTap: () {
          //                           setState(() {
          //                             newTodoGroupList[index].isOpen =
          //                                 !newTodoGroupList[index].isOpen;
          //                           });
          //                         },
          //                         minLeadingWidth: 10,
          //                         minVerticalPadding: 0,
          //                         leading: Icon(
          //                           Icons.folder_copy_outlined,
          //                           color: Colors.deepPurple,
          //                         ),
          //                         title: Text(newTodoGroupList[index].name!,
          //                             style: TextStyle(
          //                                 fontSize: 18,
          //                                 fontWeight: FontWeight.w500)),
          //                         trailing: IconButton(
          //                           icon: Icon(newTodoGroupList[0].isOpen
          //                               ? Icons.keyboard_arrow_down_outlined
          //                               : Icons.keyboard_arrow_right_outlined),
          //                           onPressed: () {
          //                             setState(() {
          //                               newTodoGroupList[index].isOpen =
          //                                   !newTodoGroupList[index].isOpen;
          //                             });
          //                           },
          //                         ),
          //                       ),
          //                       Visibility(
          //                         visible: newTodoGroupList[index].isOpen,
          //                         child: ListView.builder(
          //                           primary: false,
          //                           padding: EdgeInsets.only(
          //                               top: 0, bottom: size.height * 0.1),
          //                           shrinkWrap: true,
          //                           itemCount: 1,
          //                           itemBuilder: (context, index) {
          //                             return ListTile(
          //                                 onLongPress: () {
          //                                   // showBottomSheet(
          //                                   //     context: context,
          //                                   //     builder: (context) {
          //                                   //       return Container(
          //                                   //         height: size.height * 0.2,
          //                                   //         width: size.width,
          //                                   //         color: Colors.red,
          //                                   //       );
          //                                   //     });
          //                                   showMenu(
          //                                       context: context,
          //                                       position: RelativeRect.fromSize(
          //                                           Rect.fromLTWH(
          //                                               10,
          //                                               size.height * 0.5,
          //                                               size.width * 0.05,
          //                                               size.height * 0.2),
          //                                           size),
          //                                       items:
          //                                           // [
          //                                           //     PopupMenuItem(
          //                                           //         onTap: () {},
          //                                           //         child: Row(
          //                                           //           children: [
          //                                           //             Icon(Icons.drive_file_move_outlined),
          //                                           //             Text("Move to group")
          //                                           //           ],
          //                                           //         )),
          //                                           List.generate(2, (index) {
          //                                         return PopupMenuItem(
          //                                             child: InkWell(
          //                                           onTap: () {
          //                                             setState(() {
          //                                               newTodoGroupList[0]
          //                                                   .todoList
          //                                                   ?.add(newTodoList[0]);
          //                                               newTodoList.removeAt(0);
          //                                             });
          //                                           },
          //                                           child: Row(
          //                                             children: [
          //                                               Icon(Icons
          //                                                   .drive_file_move_outlined),
          //                                               Text("Move to group 1")
          //                                             ],
          //                                           ),
          //                                         ));
          //                                       })
          //                                       // ]
          //                                       );
          //                                 },
          //                                 onTap: () {
          //                                   setState(() {
          //                                     navIndex = 5;
          //                                     scaffoldKey.currentState!
          //                                         .closeDrawer();
          //                                   });
          //                                 },
          //                                 minLeadingWidth: 10,
          //                                 minVerticalPadding: 0,
          //                                 leading: Icon(
          //                                   Icons.list,
          //                                   color: Colors.deepPurple,
          //                                 ),
          //                                 title: Text(
          //                                     newTodoGroupList[0].todoList![0],
          //                                     style: TextStyle(
          //                                         fontSize: 18,
          //                                         fontWeight: FontWeight.w500)),
          //                                 trailing: Text('5'));
          //                           },
          //                         ),
          //                       ),
          //                     ]);
          //                   },
          //                 ),
          //                 ListView.builder(
          //                   primary: false,
          //                   padding:
          //                       EdgeInsets.only(top: 0, bottom: size.height * 0.1),
          //                   shrinkWrap: true,
          //                   itemCount: newTodoList.length,
          //                   itemBuilder: (context, index) {
          //                     return ListTile(
          //                         onLongPress: () {
          //                           // showBottomSheet(
          //                           //     context: context,
          //                           //     builder: (context) {
          //                           //       return Container(
          //                           //         height: size.height * 0.2,
          //                           //         width: size.width,
          //                           //         color: Colors.red,
          //                           //       );
          //                           //     });
          //                           showMenu(
          //                               context: context,
          //                               position: RelativeRect.fromSize(
          //                                   Rect.fromLTWH(
          //                                       10,
          //                                       size.height * 0.5,
          //                                       size.width * 0.05,
          //                                       size.height * 0.2),
          //                                   size),
          //                               items:
          //                                   // [
          //                                   //     PopupMenuItem(
          //                                   //         onTap: () {},
          //                                   //         child: Row(
          //                                   //           children: [
          //                                   //             Icon(Icons.drive_file_move_outlined),
          //                                   //             Text("Move to group")
          //                                   //           ],
          //                                   //         )),
          //                                   List.generate(4, (index) {
          //                                 return PopupMenuItem(
          //                                     child: InkWell(
          //                                   onTap: () {
          //                                     setState(() {
          //                                       newTodoGroupList[0]
          //                                           .todoList
          //                                           ?.add(newTodoList[0]);
          //                                       newTodoList.removeAt(0);
          //                                     });
          //                                   },
          //                                   child: Row(
          //                                     children: [
          //                                       Icon(
          //                                           Icons.drive_file_move_outlined),
          //                                       Text("Move to group 1")
          //                                     ],
          //                                   ),
          //                                 ));
          //                               })
          //                               // ]
          //                               );
          //                         },
          //                         onTap: () {
          //                           setState(() {
          //                             navIndex = 5;
          //                             scaffoldKey.currentState!.closeDrawer();
          //                           });
          //                         },
          //                         minLeadingWidth: 10,
          //                         minVerticalPadding: 0,
          //                         leading: Icon(
          //                           Icons.list,
          //                           color: Colors.deepPurple,
          //                         ),
          //                         title: Text(newTodoList[index],
          //                             style: TextStyle(
          //                                 fontSize: 18,
          //                                 fontWeight: FontWeight.w500)),
          //                         trailing: Text('5'));
          //                   },
          //                 ),
          //               ]),
          //         ],
          //       ),
          //       Align(
          //         alignment: Alignment.bottomCenter,
          //         child: Container(
          //           margin: EdgeInsets.only(bottom: size.height * 0.02, left: 10),
          //           height: size.height * 0.08,
          //           // color: Colors.red,
          //           child: Card(
          //             child: Padding(
          //               padding: EdgeInsets.all(10),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   InkWell(
          //                     onTap: () {
          //                       setState(() {
          //                         newTodoList.add(
          //                             'Untitled list ${newTodoList.length + 1}');
          //                         print('Untitled list ${newTodoList.length}');
          //                         title.add('Untitled list ${newTodoList.length}');
          //                         print(title);
          //                       });
          //                     },
          //                     child: Row(
          //                       children: [
          //                         Icon(Icons.add),
          //                         Padding(
          //                           padding: EdgeInsets.only(left: 10),
          //                           child: Text('New List',
          //                               style: TextStyle(
          //                                   fontSize: 18,
          //                                   fontWeight: FontWeight.w500)),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   IconButton(
          //                     icon: const Icon(Icons.note_add_outlined),
          //                     onPressed: () {
          //                       setState(() {
          //                         newTodoGroupList.add(NewTodoGroupModel(
          //                             name:
          //                                 "Untitled group ${newTodoGroupList.length + 1}"));
          //                       });
          //                     },
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //   ]),
          // ),
        )),
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (BuildContext context, state) {
            if (state is NavigationItemSelected) {
              return TodoListScreen(
                title: state.nameOfList,
              );
            } else if (state is NavigationItemMyDaySelected) {
              return const TodayTodo();
            } else {
              return const TodayTodo();
            }
            return TodayTodo();
          },
          // child: widgetsList[navIndex]),
          // bottomNavigationBar: BottomNavigationBar(
          //     items: [
          //       BottomNavigationBarItem(
          //         icon: Icon(Icons.home),
          //         label: 'Home',
          //       ),
          //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          //       BottomNavigationBarItem(
          //           icon: Icon(Icons.settings), label: 'Setting'),
          //     ],
          //     currentIndex: index,
          //     onTap: (value) {
          //       setState(() {
          //         if (value == 2) {
          //           Navigator.of(context)
          //               .push(MaterialPageRoute(builder: (context) => Setting()));
          //         } else {
          //           index = value;
          //         }
          //       });
          //     }),
        ));
  }
}

class NewTodoGroupModel {
  String? name;
  List<String>? todoList = [];
  bool isOpen = false;

  NewTodoGroupModel({this.name, this.todoList, this.isOpen = false});
}
