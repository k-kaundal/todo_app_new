import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';
import 'package:todo_app_new/src/ui/add_todo/add_todo.dart';
import 'package:todo_app_new/src/ui/todo/todo.dart';

class TodoType extends StatefulWidget {
  const TodoType({Key? key}) : super(key: key);

  @override
  State<TodoType> createState() => _TodoTypeState();
}

class _TodoTypeState extends State<TodoType> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: StreamBuilder(
            stream: TodoService().getTodoType(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Center(
                      child: Image.asset(
                        'assets/images/loading.png',
                        height: size.height * 0.2,
                      ),
                    ));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: size.height,
                  width: size.width,
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(image: AssetImage('assets/images/background.jpg',),fit: BoxFit.cover)
                  // ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/happy.gif',
                      height: size.height * 0.2,
                    ),
                  ),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return Container(
                  height: size.height,
                  width: size.width,
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(image: AssetImage('assets/images/background.jpg',),fit: BoxFit.cover)
                  // ),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/cute_cat.gif',
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
                // shrinkWrap: true,
                children:
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.01,
                        right: size.width * 0.01,
                        top: size.height * 0.005),
                    child: Stack(children: [
                      Card(
                        child: Container(
                          height: size.height * 0.05,
                          width: size.width,
                          // margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10))),
                        ),
                      ),
                      Container(
                        height: size.height * 0.05,
                        width: size.width,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                            color:
                                // data['isCheck']
                                //     ? Colors.yellowAccent
                                //     :
                                Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.green,
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: size.height * 0.01),
                                  child: Image.asset(
                                      'assets/images/check.png',
                                      height: size.height * 0.05),
                                )),
                              )),
                          Expanded(
                            flex: 8,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Todo(
                                        id: data['name'],
                                        isCheck: data['isCheck'],
                                    isImportant: data['isImportant'],)));
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'],
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
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
                                    child: Image.asset(
                                        'assets/images/delete.png',
                                        height: size.height * 0.028),
                                  ),
                                ),
                              ))
                        ]),
                      ),
                    ]),
                  );
                }).toList(),
              );
            }),
    floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
    );
  }
}
