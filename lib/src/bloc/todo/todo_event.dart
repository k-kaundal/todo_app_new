part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class TodoDelete extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class TodoComplete extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class TodoEdit extends TodoEvent {
  @override
  List<Object?> get props => [];
}
