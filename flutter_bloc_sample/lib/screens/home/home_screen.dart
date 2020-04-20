import 'package:br/blocs/todolist_bloc.dart';
import 'package:br/components/bottom_navigation_component.dart';
import 'package:br/components/card_component.dart';
import 'package:br/components/chips_component.dart';
import 'package:br/models/category_model.dart';
import 'package:br/models/todo_model.dart';
import 'package:br/screens/tasks/add_todo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int bottomIndex = 0;
  CategoryType selectedChip = CategoryType.ALL;

  TodoListBloc _todoListBloc;

  final List<CategoryType> _categories = List.of([
    CategoryType.ALL,
    CategoryType.PERSONAL,
    CategoryType.WORK,
    CategoryType.FAMILY,
    CategoryType.FRIENDS,
  ]);

  void onTapChip(CategoryType type) => setState(() {
    selectedChip = type;
  });


  void onBottomSelected(int index) => setState(() {
    bottomIndex = index;
  });

  @override
  void initState() {
    super.initState();
    _todoListBloc = TodoListBloc();
  }

  @override
  Widget build(BuildContext context) {

    _todoListBloc.filterTodo(bottomIndex: bottomIndex, category: selectedChip);

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
              child: StreamBuilder<List<Todo>>(
                stream: _todoListBloc.output,
                initialData: _todoListBloc.todos,
                builder: (context, snapshot) {

                  List<Todo> todoList = snapshot.connectionState == ConnectionState.waiting
                      ? _todoListBloc.todos
                      : snapshot.data;

                  return ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return CardComponent(
                        todo: todoList[index],
                        onCompleteTask: _todoListBloc.completeTodo,
                      );
                    }
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
          _todoListBloc.addTodo(result);
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

  @override
  void dispose() {
    _todoListBloc.dispose();
    super.dispose();
  }


}
