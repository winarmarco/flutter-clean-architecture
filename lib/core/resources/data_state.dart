import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final Exception? error;

  const DataState({this.data, this.error});
}

class RemoteDataSuccess<T> extends DataState<T> {
  const RemoteDataSuccess(T data) : super(data: data);
}

class RemoteDataFailed<T> extends DataState<T> {
  const RemoteDataFailed(DioException error) : super(error: error);
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(Exception error) : super(error: error);
}
