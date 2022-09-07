part of 'get_todo_bloc.dart';

abstract class GetTodoEvent extends Equatable {
  String id ;
  GetTodoEvent(this.id);
}
class GetTodoLoading extends GetTodoEvent{
  GetTodoLoading(super.id);

  @override
  List<Object?> get props => [id];
}
class GetTodoLoaded extends GetTodoEvent{
  GetTodoLoaded(super.id);
  @override
  List<Object?> get props => [id];
}