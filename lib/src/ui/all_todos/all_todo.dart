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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("All Todos"),
        centerTitle: false,
      ),
      body: StreamBuilder(
          stream: TodoService().getTodos(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if (snapshot.data!.docs.isEmpty) {
              return Container(
                height: size.height,
                width: size.width,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/sad.png',
                          height: size.height * 0.2,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddTodo()));
                            },
                            child: Text(
                              "Create Todo",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ]),
                ),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.01,
                      right: size.width * 0.01,
                      top: size.height * 0.01),
                  child: Card(
                      child: Container(
                    height: size.height * 0.08,
                    width: size.width,
                    color: data['isCheck']?Colors.lightGreen:Colors.black12,
                    child: Row(children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            // color: Colors.green,
                            child: InkWell(
                              onTap: () async {
                                TodoService().updateStatus(
                                    data['id'], data['isCheck'] ? false : true);
                              },
                              child: Center(
                                child: data['isCheck']
                                    ? Image.asset('assets/images/check.png',
                                        height: size.height * 0.05)
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            right: size.width * 0.023),
                                        child: Image.asset(
                                          'assets/images/unCheck.png',
                                          height: size.height * 0.02,
                                        ),
                                      ),
                              ),
                            ),
                          )),
                      Expanded(
                        flex: 8,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddTodo()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['title'],
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                data["description"],
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            // color: Colors.green,
                            child: Center(
                              child: InkWell(
                                onTap: () async {
                                  TodoService().deleteTodo(data['id']);
                                },
                                child: Image.asset('assets/images/delete.png',
                                    height: size.height * 0.035),
                              ),
                            ),
                          ))
                    ]),
                  )),
                );
              }).toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTodo()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
