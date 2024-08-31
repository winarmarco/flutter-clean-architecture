import 'package:todo_app/core/resources/data_state.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<DataState<List<TodoEntity>>> getTodos();
  Future<DataState<TodoEntity>> getTodoById(String id);
  Future<void> deleteLocal();
  Future<void> deleteRemote(String todoId);
}
