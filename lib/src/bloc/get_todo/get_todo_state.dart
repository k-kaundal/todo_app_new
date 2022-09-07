part of 'get_todo_bloc.dart';

abstract class GetTodoState extends Equatable {
  const GetTodoState();
}

class GetTodoInitial extends GetTodoState {
  @override
  List<Object> get props => [];
}

class GetTodoSuccess extends GetTodoState{
  TodoModel todoModel;
  GetTodoSuccess(this.todoModel);
  @override
  List<Object?> get props => [];
}
class GetTodoFailure extends GetTodoState{
  @override
  List<Object?> get props => [];
}