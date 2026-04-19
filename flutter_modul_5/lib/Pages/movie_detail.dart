import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    String path = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 400,
                child: Image.network(path),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  movie.overview,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
