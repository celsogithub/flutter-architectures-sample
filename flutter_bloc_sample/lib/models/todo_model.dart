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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Todo &&
              runtimeType == other.runtimeType &&
              task == other.task &&
              category == other.category &&
              complete == other.complete;

  @override
  int get hashCode =>
      task.hashCode ^
      category.hashCode ^
      complete.hashCode;
}