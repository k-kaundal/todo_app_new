import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_new/src/bloc/get_todo/get_todo_bloc.dart';
import 'package:todo_app_new/src/bloc/todo/todo_bloc.dart';
import 'package:todo_app_new/src/bloc/update_todo/update_todo_bloc.dart';
import 'package:todo_app_new/src/repo/repository/get_todo_repository.dart';
import 'package:todo_app_new/src/repo/repository/todo_repository.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';
import 'package:todo_app_new/src/ui/add_todo/add_todo.dart';

class Todo extends StatefulWidget {
  Todo({Key? key, this.id, this.isCheck, required this.isImportant})
      : super(key: key);
  String? id;
  bool? isCheck;
  bool? isImportant;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GetTodoBloc>(
            create: (BuildContext context) =>
                GetTodoBloc(GetTodoRepositoryImp())
                  ..add(GetTodoLoading(widget.id.toString())),
          ),
          BlocProvider<TodoBloc>(
            create: (context) => TodoBloc(TodoRepositoryImp()),
          ),
        ],
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoEdit) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddTodo()));
            }
          },
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoInitial) {
                return BlocBuilder<GetTodoBloc, GetTodoState>(
                  builder: (BuildContext context, state) {
                    if (state is GetTodoInitial) {
                      return Container(
                        height: size.height,
                        width: size.width,
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         image: AssetImage(
                        //           'assets/images/background.jpg',
                        //         ),
                        //         fit: BoxFit.cover)),
                        child: Center(
                          child: Image.asset(
                            'assets/images/happy.gif',
                            height: size.height * 0.2,
                          ),
                        ),
                      );
                    } else if (state is GetTodoSuccess) {
                      return Container(
                        height: size.height,
                        width: size.width,
                        child: Column(children: [
                          Expanded(
                              flex: 1,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.05,
                                          left: size.width * 0.01),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(Icons.arrow_back_ios),
                                      ),
                                    )
                                  ])),
                          Expanded(
                            flex: 10,
                            child: Row(children: [
                              Expanded(
                                flex: 10,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.05,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text("Title")),
                                        Card(
                                          elevation: 0,
                                          child: Container(
                                            width: size.width,
                                            child: Padding(
                                              padding: EdgeInsets.all(6),
                                              child: Text(
                                                state.todoModel.title
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text("Description")),
                                        Card(
                                          elevation: 0,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              width: size.width,
                                              child: Padding(
                                                padding: EdgeInsets.all(6),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        state.todoModel
                                                            .description
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      Container(
                                                        width: size.width,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              state.todoModel
                                                                  .time
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: widget
                                                                          .isCheck!
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .blue,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                            Text(
                                                              state.todoModel
                                                                  .date
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: widget
                                                                          .isCheck!
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .blue,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: size.height * 0.1,
                                        bottom: size.height * 0.1),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FloatingActionButton(
                                          backgroundColor: Colors.white,
                                          // elevation: 0,
                                          onPressed: () {
                                            context
                                                .read<TodoBloc>()
                                                .add(TodoEdit());
                                          },
                                          child: Image.asset(
                                              'assets/images/pencil.gif',
                                              height: 25),
                                        ),
                                        FloatingActionButton(
                                          backgroundColor: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              TodoService().addToImportant(
                                                  widget.id!,
                                                  widget.isImportant!
                                                      ? false
                                                      : true);
                                              widget.isImportant =
                                                  !widget.isImportant!;
                                            });
                                          },
                                          child: Icon(
                                            widget.isImportant!
                                                ? Icons.star_sharp
                                                : Icons.star_border,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        ),
                                        FloatingActionButton(
                                          backgroundColor: widget.isCheck!
                                              ? Colors.lightGreen
                                              : Colors.white,
                                          onPressed: () {
                                            context.read<UpdateTodoBloc>().add(
                                                UpdateTodoCheck(
                                                    widget.id!,
                                                    widget.isCheck!
                                                        ? false
                                                        : true));
                                            setState(() {
                                              TodoService().updateStatus(
                                                  widget.id!,
                                                  widget.isCheck!
                                                      ? false
                                                      : true);
                                              widget.isCheck = !widget.isCheck!;
                                            });
                                          },
                                          child: widget.isCheck!
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: size.width * 0.028,
                                                      bottom:
                                                          size.height * 0.012),
                                                  child: Image.asset(
                                                      'assets/images/check.png',
                                                      height: 35))
                                              : Image.asset(
                                                  'assets/images/unCheck.png',
                                                  height: 10),
                                        ),
                                        FloatingActionButton(
                                          backgroundColor: Colors.white,
                                          onPressed: () async {
                                            TodoService()
                                                .deleteTodo(widget.id!);
                                            Navigator.of(context).pop();
                                          },
                                          child: Image.asset(
                                              'assets/images/delete.png',
                                              height: 25),
                                        ),
                                      ],
                                    ),
                                  ))
                            ]),
                          ),
                        ]),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              } else if (state is TodoEditState) {
                return AddTodo(id: widget.id);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}


