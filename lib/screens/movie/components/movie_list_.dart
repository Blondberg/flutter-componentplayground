import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_componentplayground/constants.dart';
import 'package:flutter_componentplayground/screens/movie/components/movie_detail_screen.dart';
import 'package:flutter_componentplayground/screens/selection_button/components/BubbleMenu.dart';
import 'package:flutter_componentplayground/screens/selection_button/components/BubbleMenuItem.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<dynamic>? movies;

  final List<Color> _itemColors = [
    const Color(0xffAA9AFF),
    const Color(0xffFF7360),
    const Color(0xffF8AA4C),
  ];

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
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Movie List",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: size.width * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kDefaultFrame,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/searchshort.svg",
                      color: Colors.white.withOpacity(.6),
                      height: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Search",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(.6),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.filter_list_rounded,
                      color: Colors.white.withOpacity(.6),
                      size: 20,
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
                      ],
                      stops: [
                        0.0,
                        0.03,
                      ], // 10% purple, 80% transparent, 10% purple
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    shrinkWrap: true,
                    itemCount: movies == null ? 0 : movies?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(
                              movieData: movies![index],
                              color: _itemColors[index % _itemColors.length],
                            ),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: _itemColors[index % _itemColors.length],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 0,
                                spreadRadius: 0,
                                offset: Offset(4, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.network(
                                  movies![index]["Poster"],
                                  width: 47,
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    children: [
                                      TextSpan(
                                        text:
                                            "${movies![index]["Year"]} \u2022 ",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 11,
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
                icon: const Icon(Icons.search_rounded),
                onTap: () {
                  print("Scan to search");
                },
              ),
              BubbleMenuItem(
                icon: const Icon(Icons.add_rounded),
                onTap: () => print("Scan to add"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
