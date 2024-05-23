import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo_bloc.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final addTitleController = TextEditingController();

  @override
  void dispose() {
    addTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = context.read<TodoBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: addTitleController,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (addTitleController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Title cannot be empty",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    todoBloc.add(AddTodo(addTitleController.text.trim()));
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
