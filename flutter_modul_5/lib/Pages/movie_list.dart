import 'package:flutter/material.dart';
import '../service/http_service.dart';
import '../models/movie.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<Movie>? movies;
  late HttpService service;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    service = HttpService();
    initialize();
  }

  Future initialize() async {
    movies = await service.getPopularMovies();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: movies?.length ?? 0,
              itemBuilder: (context, index) {
                final movie = movies![index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(movie.title),
                    subtitle: Text('Rating: ${movie.voteAverage}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetail(movie),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}