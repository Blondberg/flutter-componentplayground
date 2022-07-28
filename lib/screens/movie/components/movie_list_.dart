import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_componentplayground/screens/movie/components/movie_detail_screen.dart';
import 'package:flutter_componentplayground/screens/selection_button/components/BubbleMenu.dart';
import 'package:flutter_componentplayground/screens/selection_button/components/BubbleMenuItem.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<Map<String, dynamic>> movies2 = List<Map<String, dynamic>>.generate(
    50,
    (index) => {
      "Title": "Dune",
      "Year": "2021",
      "Rated": "PG-13",
      "Released": "22 Oct 2021",
      "Runtime": "155 min",
      "Genre": "Action, Adventure, Drama",
      "Director": "Denis Villeneuve",
      "Writer": "Jon Spaihts, Denis Villeneuve, Eric Roth",
      "Actors": "Timothée Chalamet, Rebecca Ferguson, Zendaya",
      "Plot":
          "A noble family becomes embroiled in a war for control over the galaxy's most valuable asset while its heir becomes troubled by visions of a dark future.",
      "Language": "English, Mandarin",
      "Country": "Canada, United States",
      "Awards": "Won 6 Oscars. 162 wins & 273 nominations total",
      "Poster":
          "https://m.media-amazon.com/images/M/MV5BN2FjNmEyNWMtYzM0ZS00NjIyLTg5YzYtYThlMGVjNzE1OGViXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_SX300.jpg",
      "Ratings": [
        {"Source": "Internet Movie Database", "Value": "8.0/10"},
        {"Source": "Rotten Tomatoes", "Value": "83%"},
        {"Source": "Metacritic", "Value": "74/100"}
      ],
      "Metascore": "74",
      "imdbRating": "8.0",
      "imdbVotes": "591,378",
      "imdbID": "tt1160419",
      "Type": "movie",
      "DVD": "22 Oct 2021",
      "BoxOffice": "\$108,327,830",
      "Production": "N/A",
      "Website": "N/A",
      "Response": "True"
    },
  );

  List<dynamic>? movies;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/movies.json');
    setState(() => movies = jsonDecode(jsonText));
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Movie List",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.search, color: Colors.white, size: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 30,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.purple,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.purple
                      ],
                      stops: [
                        0.0,
                        0.05,
                        0.95,
                        1.0
                      ], // 10% purple, 80% transparent, 10% purple
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shrinkWrap: true,
                    itemCount: movies == null ? 0 : movies?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(
                              movieData: movies![index],
                            ),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          width: size.width,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.network(
                                  movies![index]["Poster"],
                                  width: 50,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: RichText(
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: "${movies![index]["Title"]} \n",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            "${movies![index]["Year"]} \u2022 ",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                "${movies![index]["Runtime"]} \u2022 ",
                                          ),
                                          TextSpan(
                                            text:
                                                "${movies![index]["Genre"]} \n",
                                          ),
                                          TextSpan(
                                            text: "${movies![index]["Actors"]}",
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          BubbleMenu(
            items: [
              BubbleMenuItem(
                icon: Icon(Icons.search_rounded),
                onTap: () {
                  print("Scan to search");
                },
              ),
              BubbleMenuItem(
                icon: Icon(Icons.add_rounded),
                onTap: () => print("Scan to add"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
