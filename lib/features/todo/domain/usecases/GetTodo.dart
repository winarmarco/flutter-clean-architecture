import 'package:todo_app/core/resources/data_state.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repository/TodoRepository.dart';

class GetTodo {
  final TodoRepository repository;

  GetTodo(this.repository);

  Future<DataState<TodoEntity>> call(String id) {
    return repository.getTodoById(id);
  }
}
