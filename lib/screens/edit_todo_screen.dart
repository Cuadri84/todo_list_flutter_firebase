import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/widget/todo_form_widget.dart';

import '../provider/todos.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit Todo'),
          actions: [
            IconButton(
                onPressed: () {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  provider.removeTodo(widget.todo);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete_sharp))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: saveTodo,
            ),
          ),
        ),
      );

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.updateTodo(
        widget.todo,
        title,
        description,
      );
      Navigator.of(context).pop();
    }
  }
}
