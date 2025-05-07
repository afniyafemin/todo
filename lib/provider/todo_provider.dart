import 'package:flutter/cupertino.dart';

import '../model/todo_model.dart';

class TodoProvider with ChangeNotifier{
  List<Todo> todos = [
    Todo(title: "todo todo")
  ];

  void addTodo(String title){
    todos.add(Todo(title: title,isCompleted: false));
    notifyListeners();
  }

  void removeTodo(Todo todo){
    todos.remove(todo);
    notifyListeners();
  }

  void toggleCompletion(Todo todo){
    final index = todos.indexOf(todo);
    todos[index].isCompleted=!todos[index].isCompleted;
    notifyListeners();
  }

}