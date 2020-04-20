import 'category_model.dart';

class Todo {

  String task;
  Category category;
  bool complete;

  Todo({
    this.task,
    this.category,
    this.complete = false
  });

}