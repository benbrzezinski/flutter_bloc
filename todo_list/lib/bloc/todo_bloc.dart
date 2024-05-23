import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:todo_list/models/todo_model.dart';
part 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, List<Todo>> {
  TodoBloc() : super([]) {
    on<AddTodo>((event, emit) {
      const uuid = Uuid();

      final newTodo = Todo(
        id: uuid.v4(),
        name: event.title,
        createdAt: DateTime.now(),
      );

      emit([...state, newTodo]);
    });

    on<DeleteTodo>((event, emit) {
      final i = state.indexWhere((todo) => todo.id == event.id);
      state.removeAt(i);
      emit([...state]);
    });

    on<UpdateTodo>((event, emit) {
      final i = state.indexWhere((todo) => todo.id == event.id);
      state[i].name = event.title;
      emit([...state]);
    });
  }
}
