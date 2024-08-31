import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/connection/network_info.dart';
import 'package:todo_app/core/resources/data_state.dart';
import 'package:todo_app/features/todo/data/repository/todo_repository_impl.dart';
import 'package:todo_app/features/todo/data/sources/local/todo_local.dart';
import 'package:todo_app/features/todo/data/sources/remote/todo_remote.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repository/TodoRepository.dart';
import 'package:todo_app/features/todo/domain/usecases/GetTodo.dart';

class TodoProvider extends ChangeNotifier {
  int count = 0;
  TodoEntity? todo;
  Exception? error;

  TodoProvider({
    this.todo,
    this.error,
  });

  void fetchTodo({required String id}) async {
    // Create a new repository/stratgey
    TodoRepository todoRepository = TodoRepositoryImpl(
      remoteDataSource: TodoRemoteDataSource(dio: Dio()),
      localDataSource:
          TodoLocalDataSource(sharedPreferences: await SharedPreferences.getInstance()),
      networkInfo: NetworkInfo(Connectivity()),
    );

    // Pass in the strategy & call
    final todoResponse = await GetTodo(todoRepository).call(id);

    if (todoResponse is RemoteDataSuccess || todoResponse is DataSuccess) {
      print("DATA IS SUCCESS");
      todo = todoResponse.data;
      error = null;
      notifyListeners();
    }

    if (todoResponse is RemoteDataFailed) {
      print("DATA IS FAIL");
      todo = null;
      error = todoResponse.error;
      notifyListeners();
    }

    if (todoResponse is DataFailed) {
      todo = null;
      error = todoResponse.error;
      notifyListeners();
    }
  }

  void deleteLocal() async {
    TodoRepository todoRepository = TodoRepositoryImpl(
      remoteDataSource: TodoRemoteDataSource(dio: Dio()),
      localDataSource:
          TodoLocalDataSource(sharedPreferences: await SharedPreferences.getInstance()),
      networkInfo: NetworkInfo(Connectivity()),
    );

    await todoRepository.deleteLocal();

    todo = null;
    notifyListeners();
  }

  void incrementCount() {
    count++;
    notifyListeners();
  }
}
