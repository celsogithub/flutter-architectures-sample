import 'package:br/components/chips_component.dart';
import 'package:br/models/category_model.dart';
import 'package:br/models/todo_model.dart';
import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  CategoryType selectedChip = CategoryType.PERSONAL;

  final _formKey = GlobalKey<FormState>();
  final _formController = TextEditingController();
  final List<CategoryType> _categories = List.of([
    CategoryType.PERSONAL,
    CategoryType.WORK,
    CategoryType.FAMILY,
    CategoryType.FRIENDS,
  ]);

  Todo todo = new Todo();

  void _onTapChip(CategoryType type) => setState(() {
    selectedChip = type;
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
                listChips: _categories,
                onTapChip: _onTapChip
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  todo.task = _formController.text;
                  todo.category = Category(
                      type: selectedChip,
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
