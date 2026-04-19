import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  Future<List?> getPopularMovies() async {
    final String uri = baseUrl;

    http.Response result = await http.get(Uri.parse(uri));

    if (result.statusCode == HttpStatus.ok) {
      print("Success");
      final jsonResponse = json.decode(result.body);
      // For now, returning as list of dynamic
      return jsonResponse;
    } else {
      print("Fail");
      return null;
    }
  }
}
