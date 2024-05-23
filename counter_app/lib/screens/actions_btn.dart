import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_app/bloc/counter_bloc.dart';

class ActionsBtn extends StatelessWidget {
  const ActionsBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.read<CounterBloc>();

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              counterBloc.add(CounterIncremented());
            },
            label: const Text("Increment"),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton.icon(
            onPressed: () {
              counterBloc.add(CounterDecremented());
            },
            label: const Text("Decrement"),
            icon: const Text(
              "-",
              style: TextStyle(fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
