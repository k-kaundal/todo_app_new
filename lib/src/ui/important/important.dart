import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';
import 'package:todo_app_new/src/ui/add_todo/add_todo.dart';
import 'package:todo_app_new/src/ui/todo/todo.dart';
class Important extends StatefulWidget {
  const Important({Key? key}) : super(key: key);

  @override
  State<Important> createState() => _ImportantState();
}

class _ImportantState extends State<Important> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
          stream: TodoService().getImportantTodos(),
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
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
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
                        height: size.height * 0.15,
                        width: size.width,
                        // margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                        decoration: BoxDecoration(
                            color: data['isCheck']
                                ? Colors.green
                                : Colors.blue,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    Container(
                      height: size.height * 0.15,
                      width: size.width,
                      margin: EdgeInsets.only(top: 10,left: 10),
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
                              child: InkWell(
                                onTap: () async {
                                  TodoService().updateStatus(data['id'],
                                      data['isCheck'] ? false : true);
                                },
                                child: Center(
                                  child: data['isCheck']
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        bottom: size.height * 0.01),
                                    child: Image.asset(
                                        'assets/images/check.png',
                                        height: size.height * 0.05),
                                  )
                                      : Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width * 0.023,
                                    ),
                                    child: Image.asset(
                                      'assets/images/unCheck.png',
                                      height: size.height * 0.015,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 8,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Todo(
                                      id: data['id'],
                                      isCheck: data['isCheck'],
                                  isImportant: data['isImportant'],)));
                            },
                            child: Container(
                              // color: Colors.black12,
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: size.height*0.01,),
                                    Text(
                                      data['title'],
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 18,
                                          decoration: data['isCheck']
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none),
                                    ),
                                    Text(
                                      data["description"],
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 15,
                                          decoration: data['isCheck']
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none),
                                    ),
                                    Container(
                                      width: size.width,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            data['time'],
                                            style: TextStyle(
                                                color: data['isCheck']
                                                    ? Colors.green
                                                    : Colors.blue,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          Text(
                                            data['date'],
                                            style: TextStyle(
                                                color: data['isCheck']
                                                    ? Colors.green
                                                    : Colors.blue,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                              // color: Colors.green,
                              child: Column(children: [
                                Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          TodoService().addToImportant(data['id'],
                                              data['isImportant'] ? false : true);
                                        });
                                      },
                                      icon: Icon(
                                        data['isImportant']
                                            ? Icons.star_sharp
                                            : Icons.star_border,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    )),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      TodoService().deleteTodo(data['id']);
                                    },
                                    child: Center(
                                      child: Image.asset(
                                          'assets/images/delete.png',
                                          height: size.height * 0.028),
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                      ]),
                    ),
                    // Align(
                    //     alignment: Alignment.topCenter,
                    //     child: Chip(label: Text("Tech",style: TextStyle(color: Colors.white),),backgroundColor: data['isCheck']
                    //     ? Colors.green
                    //         : Colors.blue,))
                  ]),
                );
              }).toList(),
            );
          }),
    );
  }
}
