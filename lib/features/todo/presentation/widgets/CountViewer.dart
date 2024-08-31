import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/todo/presentation/provider/TodoProvider.dart';

class CountViewer extends StatefulWidget {
  const CountViewer({super.key});

  @override
  State<CountViewer> createState() => _CountViewerState();
}

class _CountViewerState extends State<CountViewer> {
  void addCount() {
    Provider.of<TodoProvider>(context, listen: false).incrementCount();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: (context, data, child) {
      return Column(
        children: [
          Text(data.count.toString()),
          MaterialButton(
            onPressed: () => {addCount()},
            child: Text("Add Count"),
          )
        ],
      );
    });
  }
}
