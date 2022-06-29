import 'package:flutter/cupertino.dart';
import 'package:todo_list/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the dog',
      description: 'fhsehtewrtnnrdstdzhbtse',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the dog',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the dog',
      description: '''fhsehtewrtnnrdstdzhbtse
          fdsgsfagsag
          sagsagsagsfag''',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the dog',
    )
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }
}
