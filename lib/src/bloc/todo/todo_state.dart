part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}
class TodoEditState extends TodoState{
  @override
  List<Object?> get props => [];

}
class TodoDeleteState extends TodoState{
  @override
  List<Object?> get props => [];

}