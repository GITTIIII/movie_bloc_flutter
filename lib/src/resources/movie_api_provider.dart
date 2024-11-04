import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';
import '../models/trailer_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _baseUrl = "http://api.themoviedb.org/3/movie";
  final _apiKey = '';

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    Uri url = Uri.parse("$_baseUrl/popular?api_key=$_apiKey");
    final response = await client.get(url);
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    Uri url = Uri.parse("$_baseUrl/$movieId/videos?api_key=$_apiKey");
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
