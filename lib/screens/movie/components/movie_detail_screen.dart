import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final Map<String, dynamic> movieData;
  const MovieDetailScreen({Key? key, required this.movieData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyAppBarItem(
                      icon:
                          const Icon(Icons.close_rounded, color: Colors.white),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    MyAppBarItem(
                      icon: const Icon(Icons.edit_rounded, color: Colors.white),
                      onTap: () => print("Edit"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child:
                              Image.network(movieData["Poster"], height: 243),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            movieData["Title"].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
                              "${movieData["imdbRating"]} / 1.0",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: "Storyline    ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                  children: [
                                    TextSpan(
                                      text: movieData["Plot"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17,
                                        color: Color(0xFFF2F2F2),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              RichText(
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
                                        fontSize: 17,
                                        color: const Color(0xFFF2F2F2),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: "Stars    ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                  children: [
                                    TextSpan(
                                      text: movieData["Actors"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17,
                                        color: Color(0xFFF2F2F2),
                                      ),
                                    )
                                  ],
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
            ],
          ),
        ]),
      ),
    );
  }
}

class MyAppBarItem extends StatelessWidget {
  final Icon icon;
  final onTap;
  const MyAppBarItem({
    Key? key,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(.29),
          ),
        ),
        child: icon,
      ),
    );
  }
}
