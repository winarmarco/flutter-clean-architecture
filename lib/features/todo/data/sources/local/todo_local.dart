import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/features/todo/data/models/todo.dart';

class TodoLocalDataSource {
  final SharedPreferences sharedPreferences;

  TodoLocalDataSource({required this.sharedPreferences});

  Future<TodoModel> getLatestTodo() async {
    final String? todoJson = sharedPreferences.getString('latest_todo');
    if (todoJson != null) {
      return TodoModel.fromJSON(jsonDecode(todoJson));
    } else {
      throw Exception('No latest todo found');
    }
  }

  Future<void> saveLatestTodo(TodoModel todo) async {
    final todoJson = jsonEncode(todo.toJSON());
    await sharedPreferences.setString('latest_todo', todoJson);
  }

  Future<void> deleteLocalTodo() async {
    bool success = await sharedPreferences.remove("latest_todo");
    print("LATEST TODO REMOVAL");
    print(success);
  }
}
