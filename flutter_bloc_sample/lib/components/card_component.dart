import 'package:br/models/todo_model.dart';
import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final Todo todo;
  final ValueChanged<Todo> onCompleteTask;

  CardComponent({
    this.todo,
    this.onCompleteTask,
  }) : super(key: ObjectKey(todo));

  @override
  Widget build(BuildContext context) {
    if (todo == null) return Container();

    return Card(
      elevation: 2,
      child: ClipPath(
        child: Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Checkbox(
                value: todo.complete,
                onChanged: (bool value) => onCompleteTask(todo),
              ),
              Text(
                todo.task,
                style: todo.complete
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              )
            ],
          ),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: todo.category.color,
                width: 5,
              ),
            ),
          ),
        ),
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}
