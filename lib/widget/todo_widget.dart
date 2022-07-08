import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/todo.dart';

import '../provider/todos.dart';
import '../screens/edit_todo_screen.dart';

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
                  backgroundColor: const Color.fromARGB(255, 122, 204, 124),
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
                  backgroundColor: const Color.fromARGB(255, 255, 117, 117),
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
              activeColor: const Color.fromARGB(255, 233, 229, 214),
              checkColor: Colors.blueGrey,
              value: todo.isDone,
              side: MaterialStateBorderSide.resolveWith(
                (states) =>
                    const BorderSide(width: 2.0, color: Colors.blueGrey),
              ),
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(todo);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        isDone ? 'TODO completed' : 'TODO not yet completed')));
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
                  color: Colors.blueGrey,
                  thickness: 1.0,
                ),
                if (todo.description.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      todo.description,
                      style: const TextStyle(
                        fontSize: 18,
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
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("DELETED TODO")));
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoScreen(
            todo: todo,
          ),
        ),
      );
}
