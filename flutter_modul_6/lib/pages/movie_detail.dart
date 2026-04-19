import 'package:flutter/material.dart';
import 'package:flutter_modul_6/models/ToDo.dart';

class MovieDetail extends StatelessWidget {
  final ToDo movie;

  const MovieDetail(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title ?? "Detail"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ID: ${movie.id}"),
            Text("User ID: ${movie.userId}"),
            Text("Title: ${movie.title}"),
            Text("Completed: ${movie.completed}"),
          ],
        ),
      ),
    );
  }
}
