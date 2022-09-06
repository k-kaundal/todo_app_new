import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_new/src/model/todo_model.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';

abstract class AddTodoRepository {
  Future addTodo(TodoModel todoModel,String id);

  Future<DocumentSnapshot> getTodo(String id);
  Future<bool> checkTodo(String id);
}


class AddTodoRepositoryImp extends AddTodoRepository {
  TodoService todoService = TodoService();

  @override
  Future addTodo(TodoModel todoModel,String id) {
    return todoService.addTodo(todoModel,id);
  }

  @override
  Future<DocumentSnapshot> getTodo(String id) {
    return todoService.getTodo(id);
  }

  @override
  Future<bool> checkTodo(String id) {
   return todoService.checkTodo(id);
  }

}