import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:todo_list/models/todo_model.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void addTodo(String title) {
    const uuid = Uuid();

    final newTodo = Todo(
      id: uuid.v4(),
      name: title,
      createdAt: DateTime.now(),
    );

    emit([...state, newTodo]);
  }

  void deleteTodo(String id) {
    final i = state.indexWhere((todo) => todo.id == id);
    state.removeAt(i);
    emit([...state]);
  }

  void updateTodo({required String id, required String title}) {
    final i = state.indexWhere((todo) => todo.id == id);
    state[i].name = title;
    emit([...state]);
  }
}
