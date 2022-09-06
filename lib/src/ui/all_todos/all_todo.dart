import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_new/src/model/todo_model.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';
import 'package:todo_app_new/src/ui/add_todo/add_todo.dart';

class AllTodos extends StatefulWidget {
  const AllTodos({Key? key}) : super(key: key);

  @override
  State<AllTodos> createState() => _AllTodosState();
}

class _AllTodosState extends State<AllTodos> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(
          title: Text("All Todos"),
          centerTitle: false,
        ),
        body: StreamBuilder(
            stream: TodoService().getTodos(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              return ListView(
                  children: snapshot.data!.docs.map((
                      DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<
                        String,
                        dynamic>;
                    return Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.01,
                          right: size.width * 0.01,
                          top: size.height * 0.01),
                      child: Card(
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width,
                            color: Colors.black12,
                            child: Row(children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data['title'],style: TextStyle(fontSize: 18),),
                                    Text(data["description"])
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    // color: Colors.green,
                                    child: Center(
                                      child: Image.asset(
                                          'assets/images/check.png',
                                          height: size.height * 0.05),
                                    ),
                                  ))
                            ]),
                          )
                      ),
                    );
                  }).toList(),
              );
            }),
        floatingActionButton: FloatingActionButton(
        onPressed: ()
    {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AddTodo()));
    },
    child: Icon(Icons.add),
    ),
    );
  }
}