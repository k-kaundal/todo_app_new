import 'package:flutter/material.dart';
import 'package:todo_app_new/src/model/todo_model.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';
import 'package:uuid/uuid.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Text("Title"),
            TextFormField(
              controller: title,
              decoration:
                  InputDecoration(filled: true, border: InputBorder.none),
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
              decoration:
                  InputDecoration(filled: true, border: InputBorder.none),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {
                  setState(() {
                    title.clear();
                    desc.clear();
                  });
                }, child: Text("Clear")),
                ElevatedButton(
                    onPressed: () {
                      String id = Uuid().v4();
                      TodoModel todo =
                          TodoModel(title.text.trim(), desc.text.trim(), id);
                      if (title.text.trim() != '' && desc.text.trim() != '') {
                        TodoService().addTodo(todo, id);
                        title.clear();
                        desc.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Enter valid data"),
                        ));
                      }
                    },
                    child: Text("Save"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
