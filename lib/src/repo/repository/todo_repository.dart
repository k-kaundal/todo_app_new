import 'package:todo_app_new/src/model/todo_model.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';

abstract class TodoRepository{
  Future updateTodo(TodoModel todoModel,String id);
  Future<Stream> deleteTodo(String id);
  Future<bool> checkTodo(String id);
  Future<Stream> updateStatus(String id,value);
  
}

class TodoRepositoryImp extends TodoRepository{
  TodoService todoService = TodoService();
  @override
  Future<bool> checkTodo(String id) {
   return todoService.checkTodo(id);
  }

  @override
  Future<Stream> deleteTodo(String id) {
    return todoService.deleteTodo(id);
  }

  @override
  Future updateTodo(TodoModel todoModel, String id) {
   return todoService.updateTodo(todoModel, id);
  }

  @override
  Future<Stream> updateStatus(String id, value) {
    return todoService.updateStatus(id, value);
  }
  
}