import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';

abstract class GetTodoRepository {
  Future<DocumentSnapshot> getTodo(String id);

  Future<bool> checkTodo(String id);
}

class GetTodoRepositoryImp extends GetTodoRepository {
  TodoService todoService = TodoService();

  @override
  Future<bool> checkTodo(String id) {
    return todoService.checkTodo(id);
  }

  @override
  Future<DocumentSnapshot> getTodo(String id) {
    return todoService.getTodo(id);
  }
}
