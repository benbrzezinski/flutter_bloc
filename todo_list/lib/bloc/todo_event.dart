part of 'todo_bloc.dart';

sealed class TodoEvent {}

final class AddTodo extends TodoEvent {
  AddTodo(this.title);

  final String title;
}

final class DeleteTodo extends TodoEvent {
  DeleteTodo(this.id);

  final String id;
}

final class UpdateTodo extends TodoEvent {
  UpdateTodo({required this.id, required this.title});

  final String id;
  final String title;
}
