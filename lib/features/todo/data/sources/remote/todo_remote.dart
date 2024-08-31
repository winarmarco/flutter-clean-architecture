import 'package:dio/dio.dart';
import 'package:todo_app/features/todo/data/models/todo.dart';

class TodoRemoteDataSource {
  String apiUrl = "https://ww3jc8e4ze.execute-api.us-east-1.amazonaws.com/Prod/todos";
  final Dio _dio;

  TodoRemoteDataSource({required Dio dio}) : _dio = dio;

  Future<Response> getTodoById(String id) async {
    print("Fetching in data source");
    String url = '$apiUrl/$id';
    print(url);
    const headers = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJkOWEyY2Y3Yi0wYTBmLTQ2N2ItYTkwYS1lODdjM2NlNjg1OGIiLCJpYXQiOjE3MjQ2NTI3NDl9.KCW5ff5Qw4V1lZ0eoyYivdObLO0bY-BXJsXA1dVUhZA",
    };
    final response = await _dio.get(url,
        options: Options(
          headers: headers,
        ));
    print(response);
    return response;
  }
}
