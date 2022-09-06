part of 'add_todo_bloc.dart';

abstract class AddTodoState extends Equatable {
  const AddTodoState();
}

class AddTodoInitial extends AddTodoState {
  @override
  List<Object> get props => [];
}

class AddTodoSuccess extends AddTodoState{
  @override
  List<Object?> get props => [];
}

class AddTodoFailure extends AddTodoState{
  @override

  List<Object?> get props => [];

}
