import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/todos.dart';
import 'package:todo_list/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String title = 'TODO LIST';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: MaterialApp(
          title: title,
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home: const Home()),
    );
  }
}
