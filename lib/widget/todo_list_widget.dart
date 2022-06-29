import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/widget/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TodoWidget(
        todo: Todo(
      createdTime: DateTime.now(),
      title: 'Walk the dog',
    ));
  }
}
