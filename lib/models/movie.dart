class Movie {
  int id;
  String title;
  double voteAverage;
  String releaseDate;
  String overview;
  String posterPath;

  Movie(
      {required this.id,
      required this.title,
      required this.voteAverage,
      required this.releaseDate,
      required this.overview,
      required this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    return Movie(
        id: parsedJson['id'],
        title: parsedJson['title'],
        voteAverage: parsedJson['vote_average'] * 1.0,
        releaseDate: parsedJson['release_date'],
        overview: parsedJson['overview'],
        posterPath: parsedJson['poster_path']);
  }
}
