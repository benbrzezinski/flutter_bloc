import 'package:flutter/material.dart';
import 'package:counter_app/screens/home.dart';
import 'package:counter_app/screens/actions_btn.dart';

class Shared extends StatefulWidget {
  const Shared({super.key, required this.title});

  final String title;

  @override
  State<Shared> createState() => _SharedState();
}

class _SharedState extends State<Shared> {
  final pages = const [MyHomePage(), ActionsBtn()];
  int currentPage = 0;

  void setCurrentPage(int value) {
    setState(() {
      currentPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio_button_checked),
            label: "Actions",
          )
        ],
        currentIndex: currentPage,
        onTap: setCurrentPage,
      ),
    );
  }
}
