import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_new/src/repo/repository/todo_repository.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoInitial()) {
    on<TodoEvent>((event, emit) async {
      if(event is TodoEdit){
        emit(TodoEditState());
      }else if(event is TodoDelete){
        emit(TodoDeleteState());
      }
    });
  }
}
