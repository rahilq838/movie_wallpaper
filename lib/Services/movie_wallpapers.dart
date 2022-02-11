import 'dart:convert';

import 'package:movie_wallpaper/Models/movie_wallpaper.dart';

import '../Models/movie.dart';
import 'package:http/http.dart' as http;

const String allMovieEnd =
    'http://sumeetmathpati.pythonanywhere.com/movie_walls/movies/?format=json';
const String randWallEnd =
    'https://sumeetmathpati.pythonanywhere.com/movie_walls/walls/?format=json';

String getMovieWallEnd(int id)=> "https://sumeetmathpati.pythonanywhere.com/movie_walls/movie/${id.toString()}?format=json";

class MovieWallpapersService {
  Map<String, String> headers = {
    "Accept": "*/*",
    'Access-Control-Allow-Origin': "*",
    "Host": "sumeetmathpati.pythonanywhere.com"
  };

  parseJSON(String responseBody) {
    final parsed = json.decode(responseBody);
    print("$parsed --parsed json");
    return parsed;
  }

  Future<List<Movie>> getAllMovies() async {
    final response = await http.get(Uri.parse(allMovieEnd), headers: headers);
    // print("${response.body} bodyRes");
    // print("${response.statusCode} statusCode");
    List rawMovieData = parseJSON(response.body);
    print(rawMovieData.map((m) => Movie.fromMap(m)).toList());
    return rawMovieData.map((m) => Movie.fromMap(m)).toList();
  }

  Future<List<MovieWallpaper>> getMovieWall(Movie m) async {
    final response = await http.get(Uri.parse(getMovieWallEnd(m.id)), headers: headers);
    // print("${response.body} bodyRes");
    // print("${response.statusCode} statusCode");
    List rawMovieData = parseJSON(response.body);
    print(rawMovieData.map((m) => MovieWallpaper.fromMap(m)).toList());
    return rawMovieData.map((m) => MovieWallpaper.fromMap(m)).toList();
  }


}
