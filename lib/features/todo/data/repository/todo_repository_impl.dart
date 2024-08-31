import 'dart:io';
import 'package:dio/dio.dart';
import 'package:todo_app/core/connection/network_info.dart';
import 'package:todo_app/features/todo/data/models/todo.dart';
import 'package:todo_app/features/todo/data/sources/local/todo_local.dart';
import 'package:todo_app/features/todo/data/sources/remote/todo_remote.dart';

import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/core/resources/data_state.dart';
import 'package:todo_app/features/todo/domain/repository/TodoRepository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource _remoteDataSource;
  final TodoLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  TodoRepositoryImpl({
    required TodoRemoteDataSource remoteDataSource,
    required TodoLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;

  @override
  Future<DataState<TodoModel>> getTodoById(String id) async {
    if (await _networkInfo.isConnected()) {
      try {
        // Fetch from Remote
        final httpResponse = await _remoteDataSource.getTodoById(id);
        // Convert from JSON to TodoModel
        TodoModel todo = TodoModel.fromJSON(httpResponse.data);

        // Cache data to Local
        await _localDataSource.saveLatestTodo(todo);

        return RemoteDataSuccess(todo);
      } on DioException catch (e) {
        // On Exception
        return RemoteDataFailed(e);
      }
    } else {
      try {
        // Fetch from Local
        final todo = await _localDataSource.getLatestTodo();
        print("LATEST TODO");
        print(todo);

        // Local Success
        return DataSuccess(todo);
      } on Exception catch (e) {
        // Local fail
        return DataFailed(e);
      }
    }
  }

  @override
  Future<DataState<List<TodoEntity>>> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }

  @override
  Future<void> deleteLocal() async {
    await _localDataSource.deleteLocalTodo();
  }

  @override
  Future<void> deleteRemote(String todoId) async {}
}
