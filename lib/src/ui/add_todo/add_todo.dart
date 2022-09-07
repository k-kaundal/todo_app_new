import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_new/src/bloc/add_todo/add_todo_bloc.dart';
import 'package:todo_app_new/src/model/todo_model.dart';
import 'package:todo_app_new/src/repo/repository/add_todo_repository.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';
import 'package:uuid/uuid.dart';

class AddTodo extends StatefulWidget {
  String? id;

  AddTodo({Key? key, this.id}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  String id = const Uuid().v4();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // context.read<AddTodoBloc>().add(AddTodoStarted());
    return Scaffold(
      appBar: AppBar(
      ),
      body: BlocProvider<AddTodoBloc>(
        create: (BuildContext context) => AddTodoBloc(AddTodoRepositoryImp()),
        child: BlocBuilder<AddTodoBloc, AddTodoState>(
          builder: (BuildContext context, state) {
            // context.read<AddTodoBloc>().add(AddTodoStarted(id));
            if (state is AddTodoInitial) {
              return Container(
                height: size.height,
                width: size.width,
                // decoration: BoxDecoration(
                //     image: DecorationImage(image: AssetImage('assets/images/background.jpg',),fit: BoxFit.cover)
                // ),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: size.width * 0.05, left: size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text("Title"),
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(
                            filled: true, border: InputBorder.none),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text("Description"),
                      TextFormField(
                        controller: desc,
                        maxLines: 10,
                        minLines: 3,
                        maxLength: 1000,
                        decoration: InputDecoration(
                            filled: true, border: InputBorder.none),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              // style: ButtonStyle(
                              //   backgroundColor:
                              //       MaterialStateProperty.resolveWith((states) {
                              //     if (states.contains(MaterialState.pressed)) {
                              //       return Colors.green;
                              //     }
                              //     return Colors.blue;
                              //   }),
                              //   textStyle:
                              //       MaterialStateProperty.resolveWith((states) {
                              //     // If the button is pressed, return size 40, otherwise 20
                              //     if (states.contains(MaterialState.pressed)) {
                              //       return TextStyle(fontSize: 25);
                              //     }
                              //     return TextStyle(fontSize: 15);
                              //   }),
                              // ),
                              onPressed: () {
                                setState(() {
                                  title.clear();
                                  desc.clear();
                                });
                              },
                              child: Text("Clear")),
                          ElevatedButton(

                              onPressed: () {
                                if (widget.id == null) {
                                  TodoModel todo = TodoModel(title.text.trim(),
                                      desc.text.trim(), id, false);
                                  if (title.text.trim() != '' &&
                                      desc.text.trim() != '') {
                                    TodoService().addTodo(todo, id);
                                    title.clear();
                                    desc.clear();
                                    context
                                        .read<AddTodoBloc>()
                                        .add(AddTodoStarted(id));
                                    // Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Enter valid data"),
                                    ));
                                  }
                                } else {}
                              },
                              child: Text("Save"))
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else if (state is AddTodoSuccess) {
              return Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/background.jpg',
                        ),
                        fit: BoxFit.cover)),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/happy.gif',
                          height: size.height * 0.2,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "All Todos",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ]),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
