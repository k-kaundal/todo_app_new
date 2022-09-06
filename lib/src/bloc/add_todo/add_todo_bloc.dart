
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_new/src/model/todo_model.dart';
import 'package:todo_app_new/src/repo/repository/add_todo_repository.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';

part 'add_todo_event.dart';

part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  AddTodoRepository addTodoRepository;

  AddTodoBloc(this.addTodoRepository) : super(AddTodoInitial()) {
    on<AddTodoEvent>((event, emit) async {
      print("object");
      if (event is AddTodoStarted) {
        print("Started");
        if (await addTodoRepository.checkTodo(event.id) == true) {
          print("Done");
          emit(AddTodoSuccess());
        } else {
          emit(AddTodoFailure());
        }
      } else {
        emit(AddTodoFailure());
      }
    });
  }
}
