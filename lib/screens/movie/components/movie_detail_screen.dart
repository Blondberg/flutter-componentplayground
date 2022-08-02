import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/screens/movie/components/movie_edit_screen.dart';
import 'package:flutter_componentplayground/screens/movie/components/my_appbar_item.dart';

class MovieDetailScreen extends StatelessWidget {
  final Map<String, dynamic> movieData;
  final Color color;
  const MovieDetailScreen(
      {Key? key, required this.movieData, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 10, right: 30, left: 30),
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyAppBarItem(
                        icon: const Icon(Icons.arrow_back_ios_rounded,
                            color: Colors.white),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      MyAppBarItem(
                        icon:
                            const Icon(Icons.edit_rounded, color: Colors.white),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MovieEditScreen(),
                          ),
                        ),
                      ),
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
                          0.05,
                        ], // 10% purple, 80% transparent, 10% purple
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstOut,
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: Image.network(movieData["Poster"],
                                  height: 250),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                movieData["Title"].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Comfortaa",
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "${movieData["Year"]} \u2022 ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${movieData["Runtime"]} \u2022 ",
                                  ),
                                  TextSpan(
                                    text: "${movieData["Genre"]} \n",
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/imdblogo.jpg",
                                  height: 16,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "${movieData["imdbRating"]} / 10",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: color,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 0,
                                          spreadRadius: 0,
                                          offset: Offset(4, 4),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: "Storyline    ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                        children: [
                                          TextSpan(
                                            text: movieData["Plot"],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15,
                                              color: Color(0xFFF2F2F2),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: color,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 0,
                                          spreadRadius: 0,
                                          offset: Offset(4, 4),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: "Director    ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17),
                                        children: [
                                          TextSpan(
                                            text: movieData["Director"],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15,
                                              color: const Color(0xFFF2F2F2),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: color,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 0,
                                          spreadRadius: 0,
                                          offset: Offset(4, 4),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: "Stars    ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                        children: [
                                          TextSpan(
                                            text: movieData["Actors"],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15,
                                              color: Color(0xFFF2F2F2),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
