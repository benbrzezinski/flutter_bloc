import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo_bloc.dart';
import 'package:todo_list/screens/add_todo_screen.dart';
import 'package:todo_list/screens/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: MaterialApp(
        title: "Todo List",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple[400]!,
            primary: Colors.deepPurple[300],
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.deepPurple[300],
          ),
        ),
        initialRoute: "/",
        routes: {
          "/": (_) => const TodoListScreen(),
          "/add-todo": (_) => const AddTodoScreen(),
        },
      ),
    );
  }
}
