part of 'update_todo_bloc.dart';

abstract class UpdateTodoState extends Equatable {
  const UpdateTodoState();
}

class UpdateTodoInitial extends UpdateTodoState {
  @override
  List<Object> get props => [];
}
class UpdateTodoSuccess extends UpdateTodoState {
  @override
  List<Object> get props => [];
}
class UpdateTodoFailed extends UpdateTodoState {
  @override
  List<Object> get props => [];
}
class UpdateTodoStatusState extends UpdateTodoState{

  @override
  List<Object?> get props => [];

}
