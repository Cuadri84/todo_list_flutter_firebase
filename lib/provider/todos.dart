import 'package:flutter/cupertino.dart';
import 'package:todo_list/api/firebase_api.dart';
import 'package:todo_list/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  late List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();
  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) => FireBaseApi.createTodo(todo);

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void removeTodo(Todo todo) => FireBaseApi.deleteTodo(todo);

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FireBaseApi.updateTodo(todo);
    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String desription) {
    todo.title = title;
    todo.description = desription;
    FireBaseApi.updateTodo(todo);
  }
}
