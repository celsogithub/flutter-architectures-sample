import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/components/bottom_navigation_component.dart';
import 'package:flutter_ui_sample/components/card_component.dart';
import 'package:flutter_ui_sample/components/chips_component.dart';
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

  List<Todo> todos = List.of([]);
  List<Todo> completeTodos = List.of([]);

  final List<String> categories = List.of([
    "All",
    "Personal",
    "Work",
    "Family",
    "Friends",
  ]);

  void onTapChip(String name) => setState(() {
    selectedChip = name;
  });


  void onBottomSelected(int index) {
    setState(() {
      bottomIndex = index;
    });
  }

  void addTodo(Todo todo) => setState(() {
    todos.add(todo);
  });

  void completeTodo(Todo todo) => setState(() {
    todos.remove(todo);
    todo.complete = true;
    completeTodos.add(todo);
    print(completeTodos.length);
  });

  List<Todo> filteredTodo() {
    if (bottomIndex == 0 && selectedChip == "All") return todos;
    else if (bottomIndex == 1 && selectedChip == "All") return completeTodos;
    else if (bottomIndex == 0 && todos.length > 0) return todos.where((todo) => todo.category.name == selectedChip).toList();
    else if (bottomIndex == 1 && completeTodos.length > 0) return completeTodos.where((todo) => todo.category.name == selectedChip).toList();
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ChipsComponent(
                listChips: categories,
                onTapChip: onTapChip
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTodo().length,
                itemBuilder: (context, index) {
                  return CardComponent(
                    todo: filteredTodo()[index],
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
