import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_new/src/model/todo_model.dart';
import 'package:todo_app_new/src/repo/repository/get_todo_repository.dart';

part 'get_todo_event.dart';

part 'get_todo_state.dart';

class GetTodoBloc extends Bloc<GetTodoEvent, GetTodoState> {
  GetTodoRepository getTodoRepository;

  GetTodoBloc(this.getTodoRepository) : super(GetTodoInitial()) {
    on<GetTodoEvent>((event, emit) async {
      if (event is GetTodoLoading) {
        DocumentSnapshot snapshot = await getTodoRepository.getTodo(event.id);
        Map<String, dynamic> toData = snapshot.data() as Map<String, dynamic>;
        // getTodoRepository.getTodo(event.id);
        TodoModel todoModel = TodoModel.fromJson(toData);
        print(todoModel.id);
        if(todoModel.id != null) {
          emit(GetTodoSuccess(todoModel));
        }else{
          emit(GetTodoFailure());
        }
      } else {
        print("Error");
      }
    });
  }
}
