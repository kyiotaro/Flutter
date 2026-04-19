import 'package:flutter/material.dart';
import 'package:flutter_modul_6/service/http_service.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  int moviesCount = 0;
  List? movies;
  late HttpService service;

  Future initialize() async {
    movies = await service.getPopularMovies();
    setState(() {
      moviesCount = movies?.length ?? 0;
      movies = movies;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
      ),
      body: ListView.builder(
        itemCount: moviesCount,
        itemBuilder: (context, position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(movies![position].title),
              subtitle: Text("Status: ${movies![position].completed}"),
            ),
          );
        },
      ),
    );
  }
}
