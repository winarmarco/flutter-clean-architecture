import 'package:todo_app/features/todo/domain/entities/todo.dart';

// Like a table
class TodoModel extends TodoEntity {
  const TodoModel({String? id, String? title, String? description})
      : super(id: id, title: title, description: description);

  factory TodoModel.fromJSON(Map<String, dynamic> jsonObject) {
    return TodoModel(
      id: jsonObject["id"] ?? "",
      title: jsonObject["title"] ?? "",
      description: jsonObject["description"] ?? "",
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": id ?? "",
      "title": title ?? "",
      "description": description ?? "",
    };
  }
}
