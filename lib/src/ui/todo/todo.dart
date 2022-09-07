import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_new/src/bloc/get_todo/get_todo_bloc.dart';
import 'package:todo_app_new/src/repo/repository/get_todo_repository.dart';

class Todo extends StatefulWidget {
  Todo({Key? key, this.id}) : super(key: key);
  String? id;

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
      appBar: AppBar(),
      body: BlocProvider<GetTodoBloc>(
        create: (BuildContext context) => GetTodoBloc(GetTodoRepositoryImp())
          ..add(GetTodoLoading(widget.id.toString())),
        child: BlocBuilder<GetTodoBloc, GetTodoState>(
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
                child: Row(children: [
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.02,
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
                                    state.todoModel.title.toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                              child: Container(
                                width: size.width,
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    state.todoModel.description.toString(),
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
                        margin: EdgeInsets.only(top: size.height*0.1,bottom: size.height*0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                              backgroundColor: Colors.white,
                              // elevation: 0,
                              onPressed: () {},
                              child: Image.asset('assets/images/pencil.gif',height: 25),
                            ),
                            FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {},
                              child: Image.asset('assets/images/unCheck.png',height: 10),
                            ),
                            FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {},
                              child: Image.asset('assets/images/unCheck.png',height: 10),
                            ),
                            FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {},
                              child: Padding(padding: EdgeInsets.only(left: size.width*0.028,bottom: size.height*0.012),
                              child: Image.asset('assets/images/check.png',height: 35)),
                            ),
                            FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {},
                              child: Image.asset('assets/images/delete.png',height: 25),
                            ),
                          ],
                        ),
                      ))
                ]),
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
