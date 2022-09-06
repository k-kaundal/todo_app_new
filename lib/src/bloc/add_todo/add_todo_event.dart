part of 'add_todo_bloc.dart';

abstract class AddTodoEvent extends Equatable {
  const AddTodoEvent();
}
class AddTodoStarted extends AddTodoEvent{
  String id;
  AddTodoStarted(this.id);
  @override
  List<Object?> get props => [id];
}
class AddTodoAdded extends AddTodoEvent{

  @override
  List<Object?> get props => [];

}




