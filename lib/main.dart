import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/todo/presentation/provider/TodoProvider.dart';
import 'package:todo_app/features/todo/presentation/widgets/CountViewer.dart';
import 'package:todo_app/features/todo/presentation/widgets/TodoViewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => TodoProvider())],
        child: MaterialApp(
          home: const Home(),
        ));
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
        ),
        body: Column(
          children: [const TodoViewer()],
        ));
  }
}
