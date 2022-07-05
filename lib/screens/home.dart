import 'package:flutter/material.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/widget/todo_list_widget.dart';

import '../dialogs/add_dialog.dart';
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
      backgroundColor: Colors.amber,
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
          backgroundColor: Colors.grey,
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
      body: tabs[selectedIndex],
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
