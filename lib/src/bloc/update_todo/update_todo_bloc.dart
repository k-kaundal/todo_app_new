import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_new/src/repo/repository/todo_repository.dart';
import 'package:todo_app_new/src/repo/service/todo_service.dart';

part 'update_todo_event.dart';

part 'update_todo_state.dart';

class UpdateTodoBloc extends Bloc<UpdateTodoEvent, UpdateTodoState> {
  TodoRepository todoRepository;
  UpdateTodoBloc(this.todoRepository) : super(UpdateTodoInitial()) {
    on<UpdateTodoEvent>((event, emit) async {
      if (event is UpdateTodoCheck) {
        todoRepository.updateStatus(event.id, event.value);
        emit(UpdateTodoStatusState());
      } else if (event is UpdateTodoCancle) {
        emit(UpdateTodoFailed());
      } else if (event is UpdateTodoUpdating) {
        emit(UpdateTodoSuccess());
      }
    });
  }
}

