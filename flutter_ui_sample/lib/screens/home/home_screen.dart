import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/components/bottom_navigation_component.dart';
import 'package:flutter_ui_sample/components/card_component.dart';
import 'package:flutter_ui_sample/components/chips_component.dart';
import 'package:flutter_ui_sample/models/category_model.dart';
import 'package:flutter_ui_sample/models/todo_model.dart';
import 'package:flutter_ui_sample/screens/tasks/add_todo.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int bottomIndex = 0;
  String selectedChip = "All";

  List<Todo> _todos = List.of([]);
  List<Todo> _completeTodos = List.of([]);

  final List<String> _categories = List.of([
    "All",
    "Personal",
    "Work",
    "Family",
    "Friends",
  ]);

  void onTapChip(String name) => setState(() {
    selectedChip = name;
  });


  void onBottomSelected(int index) => setState(() {
    bottomIndex = index;
  });

  void addTodo(Todo todo) => setState(() {
    _todos.add(todo);
  });

  void completeTodo(Todo todo) {
    todo.complete = true;
    setState(() {
      _todos.remove(todo);
      _completeTodos.add(todo);
    });
  }

  List<Todo> filterTodo() {
    if (bottomIndex == 0 && selectedChip == "All") return _todos;
    else if (bottomIndex == 1 && selectedChip == "All") return _completeTodos;
    else if (bottomIndex == 0 && _todos.length > 0) return _todos.where((todo) => todo.category.name == selectedChip).toList();
    else if (bottomIndex == 1 && _completeTodos.length > 0) return _completeTodos.where((todo) => todo.category.name == selectedChip).toList();
    else return [];
  }

  @override
  Widget build(BuildContext context) {

    List<Todo> filteredTodo = filterTodo();

    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ChipsComponent(
                listChips: _categories,
                onTapChip: onTapChip
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTodo.length,
                itemBuilder: (context, index) {
                  return CardComponent(
                    todo: filteredTodo[index],
                    onCompleteTask: completeTodo,
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Todo result = await Navigator.push(context, MaterialPageRoute(builder: (_) => AddTodo()));
          addTodo(result);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigation(
        bottomIndex: bottomIndex,
        onBottomSelected: onBottomSelected
      ),
    );
  }

}
