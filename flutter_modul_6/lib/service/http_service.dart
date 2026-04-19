import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_modul_6/models/ToDo.dart';

class HttpService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<ToDo>?> getPopularMovies() async {
    final String uri = baseUrl;

    http.Response result = await http.get(Uri.parse(uri));

    if (result.statusCode == HttpStatus.ok) {
      print("Success");
      final List jsonResponse = json.decode(result.body);
      List<ToDo> todos = jsonResponse.map((i) => ToDo.fromJson(i)).toList();
      return todos;
    } else {
      print("Fail");
      return null;
    }
  }
}
