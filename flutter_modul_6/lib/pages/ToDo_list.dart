import 'package:flutter/material.dart';
import 'package:flutter_modul_6/service/http_service.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  String result = "";
  late HttpService service;

  @override
  void initState() {
    service = HttpService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    service.getPopularMovies()?.then((value) {
      setState(() {
        result = value.toString();
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
      ),
      body: Container(
        child: Text(result),
      ),
    );
  }
}
