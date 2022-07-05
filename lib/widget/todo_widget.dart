import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/todo.dart';

import '../provider/todos.dart';
import '../screens/edit_todo_screen.dart';
import '../utils/utils.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          key: Key(todo.id),
          startActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) => editTodo(context, todo),
                  backgroundColor: const Color.fromARGB(255, 27, 203, 29),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                ),
              ]),
          endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) => deleteTodo(context, todo),
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                ),
              ]),
          child: buildTodo(context),
        ),
      );
  Widget buildTodo(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          children: [
            Checkbox(
              activeColor: Colors.amber,
              checkColor: Colors.grey,
              value: todo.isDone,
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(todo);

                Utils.showSnackBar(context,
                    isDone ? 'Task completed' : 'Task not yet completed');
              },
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1.0,
                ),
                if (todo.description.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      todo.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  )
              ],
            ))
          ],
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted Task');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoScreen(
            todo: todo,
          ),
        ),
      );
}
