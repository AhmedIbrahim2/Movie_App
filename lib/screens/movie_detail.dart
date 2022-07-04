import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String imagePath = 'https://image.tmdb.org/t/p/w500';
  const MovieDetail({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String path;
    if (movie.posterPath != null) {
      path = imagePath + movie.posterPath;
    } else {
      path =
          "https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg";
    }
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
                height: height / 1.5,
                child: Image.network(path),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(movie.overview),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  'Vote: ' + movie.voteAverage.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
