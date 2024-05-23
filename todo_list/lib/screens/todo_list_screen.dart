import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo_bloc.dart';
import 'package:todo_list/models/todo_model.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final updateTitleController = TextEditingController();

  @override
  void dispose() {
    updateTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = context.read<TodoBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: BlocBuilder<TodoBloc, List<Todo>>(
        builder: (context, todoList) => todoList.isNotEmpty
            ? ListView.builder(
                clipBehavior: Clip.antiAlias,
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  final todo = todoList[index];

                  return ListTile(
                    title: Text(todo.name),
                    subtitle: Text(
                      todo.createdAt.toString(),
                    ),
                    trailing: SizedBox(
                      width: 96,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: Dialog(
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    controller:
                                                        updateTitleController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: "New title",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      if (updateTitleController
                                                          .text
                                                          .trim()
                                                          .isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                              "Title cannot be empty",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        todoBloc.add(
                                                          UpdateTodo(
                                                            id: todo.id,
                                                            title:
                                                                updateTitleController
                                                                    .text
                                                                    .trim(),
                                                          ),
                                                        );
                                                        updateTitleController
                                                            .clear();
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: const Text("Update"),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              todoBloc.add(DeleteTodo(todo.id));
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    tileColor: Theme.of(context).colorScheme.inversePrimary,
                  );
                })
            : const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text("Todo list is empty"),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add-todo");
        },
        tooltip: "Add Todo",
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
