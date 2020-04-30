import 'package:br/blocs/todolist_bloc.dart';
import 'package:br/models/category_model.dart';
import 'package:br/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.dart';

void main() {
    group('Todo List Block', () {
      TodoListBloc todoListBloc;
      
      setUp(() {
        todoListBloc = TodoListBloc();
      });

      tearDown(() {
        todoListBloc.dispose();
      });
        
      test('Should add a todo in todo\'s list', () {
        // given
        final todo = _buildFakeTodo();

        // then
        expect(todoListBloc.output, emits([todo]));

        // when
        todoListBloc.addTodo(todo);
      });

      test('Should complete a todo', () {
        // given
        final todo = _buildFakeTodo();

        // when
        todoListBloc.addTodo(todo);
        todoListBloc.completeTodo(todo);

        // Then
        expect(todoListBloc.todos.isNotEmpty, true);
        expect(todoListBloc.todos[0].complete, true);
      });

      test('Should filter todos by all categories and completed', () {
        // given
        final Todo todo1 = MockTodo();
        when(todo1.complete).thenAnswer((_) => false);
        todoListBloc.addTodo(todo1);

        final Todo todo2 = MockTodo();
        when(todo2.complete).thenAnswer((_) => false);
        todoListBloc.addTodo(todo2);

        // Then
        expect(
          todoListBloc.output, 
          emits([todo1, todo2]),
        );      

        // when
        todoListBloc.filterTodo(bottomIndex: 0);
      });
    });
}

Todo _buildFakeTodo() {
  final CategoryType type = CategoryType.PERSONAL;
  final Color color = Category.colorByName(type);
  final Category category = Category(type: type, color: color);
  final String task = 'Write a letter';
  return Todo(task: task, category: category);
}
