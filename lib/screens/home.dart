import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/api/firebase_api.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/widget/todo_list_widget.dart';

import '../dialogs/add_dialog.dart';
import '../model/todo.dart';
import '../provider/todos.dart';
import '../widget/completed_list_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const TodoListWidget(),
      const CompletedListWidget(),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 229, 214),
      appBar: AppBar(
        title: const Center(
          child: Text(MyApp.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              )),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blueGrey,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          selectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          onTap: (index) => setState(() {
                selectedIndex = index;
              }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration_sharp),
              label: 'TODOS',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_box_sharp), label: 'DONE'),
          ]),
      body: StreamBuilder<List<Todo>>(
          stream: FireBaseApi.readTodos(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const Text('Something Went Wrong Try later');
                } else {
                  final todos = snapshot.data!.toList();

                  final provider = Provider.of<TodosProvider>(context);
                  provider.setTodos(todos);

                  return tabs[selectedIndex];
                }
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AddDialog();
          },
        ),
        child: const Icon(
          Icons.add_sharp,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
