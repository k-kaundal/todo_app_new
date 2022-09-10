part of 'update_todo_bloc.dart';

abstract class UpdateTodoEvent extends Equatable {
  const UpdateTodoEvent();
}

class UpdateTodoUpdating extends UpdateTodoEvent{
  @override
  List<Object?> get props => [];
}
class UpdateTodoCancle extends UpdateTodoEvent{
  @override
  List<Object?> get props => [];
}
class UpdateTodoCheck extends UpdateTodoEvent{
  String id;
  bool value;
  UpdateTodoCheck(this.id,this.value);
  @override
  List<Object?> get props => [id,value];
}
