import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import '../models/movie.dart';

class HttpService {

  final String baseUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=';
  final String apiKey = '4ba720808c0f20290c7f6c74106a5d31';

  Future<List<Movie>?> getPopularMovies() async {
    final String url = baseUrl + apiKey;

    http.Response result = await http.get(Uri.parse(url));
    if(result.statusCode == HttpStatus.ok) {
      print ("sukses");
      final Map<String, dynamic> responseData = json.decode(result.body);
      final List results = responseData['results'];
      List<Movie> movies = results.map((e) => Movie.fromJson(e)).toList();
      return movies;
    } else {
      print ("gagal");
      return null;
    }
  } 
}