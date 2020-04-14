import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/components/chips_component.dart';
import 'package:flutter_ui_sample/models/category_model.dart';
import 'package:flutter_ui_sample/models/todo_model.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  String selectedChip = "Personal";

  final _formKey = GlobalKey<FormState>();
  final _formController = TextEditingController();
  final List<String> categories = List.of([
    "Personal",
    "Work",
    "Family",
    "Friends",
  ]);

  Todo todo = new Todo();

  void _onTapChip(String name) => setState(() {
    selectedChip = name;
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Todo"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            TextFormField(
              controller: _formController,
              decoration: const InputDecoration(
                hintText: 'Your task description',
                labelText: 'Todo',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            ChipsComponent(
                listChips: categories,
                onTapChip: _onTapChip
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  todo.task = _formController.text;
                  todo.category = Category(
                      name: selectedChip,
                      color: Category.colorByName(selectedChip)
                  );
                  Navigator.pop(context, todo);
                }
              },
              child: Text('Create'),
            )
          ]),
        ),
      ),
    );
  }
}
