import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/todo/presentation/provider/TodoProvider.dart';

class TodoViewer extends StatefulWidget {
  const TodoViewer({super.key});

  @override
  State<TodoViewer> createState() => _TodoViewerState();
}

class _TodoViewerState extends State<TodoViewer> {
  int count = 0;

  @override
  void initState() {
    Provider.of<TodoProvider>(context, listen: false)
        .fetchTodo(id: "2c2e68e8-a608-4e47-b9b6-7af76361295a");
    super.initState();
  }

  void fetchData() {
    Provider.of<TodoProvider>(context, listen: false)
        .fetchTodo(id: "2c2e68e8-a608-4e47-b9b6-7af76361295a");
    print("DONE FETCHING DATA");
    count++;
  }

  void deleteLocal() {
    Provider.of<TodoProvider>(context, listen: false).deleteLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: (context, data, child) {
      print("DATA .TODO");
      print(data.todo);
      print(data.error);
      return Column(
        children: [
          if (data.error != null) Text(data.error.toString()),
          if (data.todo != null) Text(data.todo!.title ?? ""),
          if (data.todo == null && data.error == null) CircularProgressIndicator(),
          MaterialButton(
            child: Text("FETCH DATA"),
            onPressed: () {
              print("Press");
              fetchData();
            },
          ),
          MaterialButton(
            child: Text("DELETE LOCAL DATA"),
            onPressed: () {
              print("DELETE LOCAL");
              deleteLocal();
            },
          )
        ],
      );
    });
  }
}
