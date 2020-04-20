import 'dart:async';

import 'package:br/models/category_model.dart';
import 'package:br/models/todo_model.dart';
import 'package:flutter/cupertino.dart';

class TodoListBloc {

  List<Todo> _todos = List.of([]);
  List<Todo> get todos => _todos;

  final _todoListController = StreamController<List<Todo>>();

  Sink<List<Todo>> get input => _todoListController.sink;
  Stream<List<Todo>> get output => _todoListController.stream;

  void addTodo(Todo todo) {
    _todos.add(todo);
    input.add(_todos);
  }

  void completeTodo(Todo todo) {
    _todos.remove(todo);
    todo.complete = true;
    _todos.add(todo);
    filterTodo(bottomIndex: 0);
  }

  void filterTodo({
    @required int bottomIndex,
    CategoryType category = CategoryType.ALL
  }) {
    var todosList;

    if (bottomIndex == 0 && category == CategoryType.ALL) todosList = _todos.where((todo) => !todo.complete).toList();
    else if (bottomIndex == 1 && category == CategoryType.ALL) todosList = _todos.where((todo) => todo.complete).toList();
    else if (bottomIndex == 0) todosList = _todos.where((todo) => todo.category.type == category && !todo.complete).toList();
    else if (bottomIndex == 1) todosList = _todos.where((todo) => todo.category.type == category && todo.complete).toList();

    input.add(todosList);
  }

  void dispose() => _todoListController.close();

}