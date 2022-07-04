import 'package:flutter/material.dart';
import 'package:movie_app/helper/http_helper.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final String iconBase = 'https://image.tmdb.org/t/p/w92';
  String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  List<Movie> movies = [];
  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Movies');

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      var upcomingMovies = await HttpHelper.getUpcoming();
      setState(() {
        movies = upcomingMovies;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (visibleIcon.icon == Icons.search) {
                  visibleIcon = const Icon(Icons.cancel);
                  searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    onChanged: (text) async {
                      var listMovies = await HttpHelper.findMovies(text);
                      setState(() {
                        movies = listMovies;
                      });
                    },
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  );
                } else {
                  setState(() {
                    visibleIcon = const Icon(Icons.search);
                    searchBar = const Text('Movies');
                  });
                }
              });
            },
            icon: visibleIcon,
          )
        ],
      ),
      body: movies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: (movies == []) ? 0 : movies.length,
              itemBuilder: (context, position) {
                if (movies[position].posterPath != null) {
                  image = NetworkImage(iconBase + movies[position].posterPath);
                } else {
                  image = NetworkImage(defaultImage);
                }
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetail(movie: movies[position]),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: image,
                    ),
                    title: Text(movies[position].title),
                    subtitle: Text('Released: ' +
                        movies[position].releaseDate +
                        ' - Vote: ' +
                        movies[position].voteAverage.toString()),
                  ),
                );
              }),
    );
  }
}
